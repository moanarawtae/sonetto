import chokidar from 'chokidar';
import path from 'node:path';
import { SUPPORTED_AUDIO_FORMATS } from '../../common/constants';
import { log } from './logger';
import { scanLibrary } from './libraryScanner';

const watchers = new Map<string, chokidar.FSWatcher>();

const isSupported = (filePath: string) => {
  const ext = path.extname(filePath).slice(1).toLowerCase();
  return SUPPORTED_AUDIO_FORMATS.includes(ext as (typeof SUPPORTED_AUDIO_FORMATS)[number]);
};

export const startWatching = (folders: string[]) => {
  for (const folder of folders) {
    if (watchers.has(folder)) {
      continue;
    }
    const watcher = chokidar.watch(folder, {
      ignoreInitial: true,
      depth: 10,
      awaitWriteFinish: true
    });

    watcher.on('add', async (filePath) => {
      if (isSupported(filePath)) {
        log.info('New file detected: %s, rescanning folder.', filePath);
        await scanLibrary([folder]);
      }
    });

    watcher.on('change', async (filePath) => {
      if (isSupported(filePath)) {
        log.info('File changed: %s, rescanning folder.', filePath);
        await scanLibrary([folder]);
      }
    });

    watcher.on('unlink', async (filePath) => {
      if (isSupported(filePath)) {
        log.info('File removed: %s, rescanning folder.', filePath);
        await scanLibrary([folder]);
      }
    });

    watchers.set(folder, watcher);
  }
};

export const stopWatching = async () => {
  for (const watcher of watchers.values()) {
    await watcher.close();
  }
  watchers.clear();
};
