import crypto from 'node:crypto';
import fs from 'node:fs';
import path from 'node:path';
import { promisify } from 'node:util';
import { parseFile } from 'music-metadata';
import { SUPPORTED_AUDIO_FORMATS, COVER_CACHE_DIR } from '../../common/constants';
import type { AudioFormat, ScanProgressPayload, ScanResult } from '../../common/types';
import {
  getDatabase,
  insertFolder,
  listFolders,
  recordScanResult,
  removeTracksNotInPaths,
  upsertAlbum,
  upsertArtist,
  upsertTrack
} from './database';
import { log } from './logger';

const mkdir = promisify(fs.mkdir);
const access = promisify(fs.access);
const writeFile = promisify(fs.writeFile);
const stat = promisify(fs.stat);
const readdir = promisify(fs.readdir);

const AUDIO_EXTENSIONS = SUPPORTED_AUDIO_FORMATS;

interface ScanOptions {
  onProgress?: (payload: ScanProgressPayload) => void;
}

const isAudioFile = (filename: string): AudioFormat | null => {
  const ext = path.extname(filename).slice(1).toLowerCase();
  if (AUDIO_EXTENSIONS.includes(ext as AudioFormat)) {
    return ext as AudioFormat;
  }
  return null;
};

const findLrcFile = async (audioPath: string): Promise<boolean> => {
  const dir = path.dirname(audioPath);
  const base = path.basename(audioPath, path.extname(audioPath));
  const candidate = path.join(dir, `${base}.lrc`);
  try {
    await access(candidate, fs.constants.F_OK);
    return true;
  } catch {
    return false;
  }
};

const ensureCoverDirectory = async (): Promise<string> => {
  const db = getDatabase();
  const dir = path.join(path.dirname(db.name), COVER_CACHE_DIR);
  try {
    await access(dir, fs.constants.F_OK);
  } catch {
    await mkdir(dir, { recursive: true });
  }
  return dir;
};

const saveCoverArt = async (pictures: { format: string; data: Buffer }[] | undefined, audioPath: string) => {
  const dir = await ensureCoverDirectory();
  let picture = pictures?.[0];
  if (!picture) {
    const folderCandidates = ['cover.jpg', 'cover.png', 'folder.jpg', 'folder.png'];
    for (const candidate of folderCandidates) {
      const coverPath = path.join(path.dirname(audioPath), candidate);
      try {
        const buffer = await fs.promises.readFile(coverPath);
        picture = { format: path.extname(candidate).slice(1), data: buffer };
        break;
      } catch {
        // ignore missing file
      }
    }
  }

  if (!picture) {
    return null;
  }

  const hash = crypto.createHash('sha1').update(picture.data).digest('hex');
  const extension = picture.format?.includes('png') ? 'png' : 'jpg';
  const coverPath = path.join(dir, `${hash}.${extension}`);
  try {
    await access(coverPath, fs.constants.F_OK);
  } catch {
    await writeFile(coverPath, picture.data);
  }
  return hash;
};

const averageColorFromBuffer = (buffer: Buffer): string | null => {
  if (buffer.length < 3) {
    return null;
  }
  let r = 0;
  let g = 0;
  let b = 0;
  const total = Math.min(buffer.length - (buffer.length % 3), 3000);
  if (total <= 0) {
    return null;
  }
  for (let i = 0; i < total; i += 3) {
    r += buffer[i];
    g += buffer[i + 1];
    b += buffer[i + 2];
  }
  const samples = total / 3;
  const avgR = Math.round(r / samples);
  const avgG = Math.round(g / samples);
  const avgB = Math.round(b / samples);
  return `#${avgR.toString(16).padStart(2, '0')}${avgG.toString(16).padStart(2, '0')}${avgB
    .toString(16)
    .padStart(2, '0')}`;
};

const walkDirectory = async (dir: string, results: string[]) => {
  const entries = await readdir(dir, { withFileTypes: true });
  for (const entry of entries) {
    const res = path.join(dir, entry.name);
    if (entry.isDirectory()) {
      await walkDirectory(res, results);
    } else if (entry.isFile() && isAudioFile(entry.name)) {
      results.push(res);
    }
  }
};

export const scanLibrary = async (
  folders: string[],
  options: ScanOptions = {}
): Promise<ScanResult> => {
  const onProgress = options.onProgress;
  const start = Date.now();
  let imported = 0;
  let updated = 0;

  for (const folder of folders) {
    insertFolder(folder);
    const folderRecord = listFolders().find((f) => f.path === folder);
    if (!folderRecord) {
      continue;
    }
    const audioFiles: string[] = [];
    await walkDirectory(folder, audioFiles);
    let processed = 0;
    const folderPaths: string[] = [];
    for (const filePath of audioFiles) {
      try {
        const format = isAudioFile(filePath);
        if (!format) {
          continue;
        }
        const metadata = await parseFile(filePath, { duration: true });
        const hasLrc = await findLrcFile(filePath);
        let coverHash: string | null = null;
        if (metadata.common.picture?.[0]) {
          coverHash = await saveCoverArt(metadata.common.picture, filePath);
        } else {
          coverHash = await saveCoverArt(undefined, filePath);
        }

        const stats = await stat(filePath);
        const added_at = new Date(stats.birthtimeMs || stats.ctimeMs).toISOString();
        const { inserted } = upsertTrack({
          path: filePath,
          title: metadata.common.title ?? path.basename(filePath),
          artist: metadata.common.artist ?? null,
          album: metadata.common.album ?? null,
          track_no: metadata.common.track?.no ?? null,
          disc_no: metadata.common.disk?.no ?? null,
          duration: metadata.format.duration ?? null,
          bitrate: metadata.format.bitrate ? Math.round(metadata.format.bitrate) : null,
          sample_rate: metadata.format.sampleRate ?? null,
          channels: metadata.format.numberOfChannels ?? null,
          format,
          genre: metadata.common.genre?.[0] ?? null,
          year: metadata.common.year ?? null,
          added_at,
          folder_id: folderRecord.id,
          has_lrc: hasLrc ? 1 : 0,
          cover_hash: coverHash
        });

        upsertArtist(metadata.common.artist ?? null);
        upsertAlbum(
          metadata.common.album ?? null,
          metadata.common.artist ?? null,
          metadata.common.year ?? null,
          coverHash
        );

        folderPaths.push(filePath);
        if (inserted) {
          imported += 1;
        } else {
          updated += 1;
        }
      } catch (error) {
        log.error('Failed to process %s: %s', filePath, (error as Error).message);
      }
      processed += 1;
      if (onProgress) {
        onProgress({ processed, total: audioFiles.length, currentPath: filePath });
      }
    }
    removeTracksNotInPaths(folderRecord.id, folderPaths);
  }

  const result: ScanResult = {
    foldersScanned: folders.length,
    tracksImported: imported,
    tracksUpdated: updated,
    durationMs: Date.now() - start
  };
  recordScanResult(result);
  return result;
};

const findCoverFile = async (hash: string): Promise<string | null> => {
  const db = getDatabase();
  const dir = path.join(path.dirname(db.name), COVER_CACHE_DIR);
  const matches = await fs.promises.readdir(dir).catch(() => [] as string[]);
  const file = matches.find((name) => name.startsWith(hash));
  if (!file) {
    return null;
  }
  return path.join(dir, file);
};

export const computeAverageColor = async (hash: string): Promise<string | null> => {
  const filePath = await findCoverFile(hash);
  if (!filePath) {
    return null;
  }
  try {
    const buffer = await fs.promises.readFile(filePath);
    return averageColorFromBuffer(buffer);
  } catch (error) {
    log.warn('Failed to compute average color for %s: %s', hash, (error as Error).message);
    return null;
  }
};

export const resolveCoverArt = async (hash: string): Promise<string | null> => {
  return findCoverFile(hash);
};
