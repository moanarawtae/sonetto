import path from 'node:path';
import { app } from 'electron';
import Database from 'better-sqlite3';
import { DB_FILE_NAME } from '../../common/constants';
import type {
  AlbumRecord,
  ArtistRecord,
  LibrarySummary,
  PaginatedResult,
  PlaylistRecord,
  PlaylistTrackRecord,
  PlaylistWithTracks,
  ScanResult,
  TrackListQuery,
  TrackRecord
} from '../../common/types';
import { log } from './logger';

type SqliteDatabase = InstanceType<typeof Database>;

let db: SqliteDatabase | null = null;

const MIGRATION_STEPS: string[] = [
  `CREATE TABLE IF NOT EXISTS folders (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      path TEXT UNIQUE NOT NULL,
      include INTEGER DEFAULT 1 NOT NULL,
      added_at TEXT DEFAULT CURRENT_TIMESTAMP NOT NULL
    );`,
  `CREATE TABLE IF NOT EXISTS artists (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT UNIQUE NOT NULL
    );`,
  `CREATE TABLE IF NOT EXISTS albums (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
      artist TEXT,
      year INTEGER,
      cover_hash TEXT
    );`,
  `CREATE TABLE IF NOT EXISTS tracks (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      path TEXT UNIQUE NOT NULL,
      title TEXT NOT NULL,
      artist TEXT,
      album TEXT,
      track_no INTEGER,
      disc_no INTEGER,
      duration REAL,
      bitrate INTEGER,
      sample_rate INTEGER,
      channels INTEGER,
      format TEXT NOT NULL,
      genre TEXT,
      year INTEGER,
      added_at TEXT DEFAULT CURRENT_TIMESTAMP NOT NULL,
      folder_id INTEGER,
      has_lrc INTEGER DEFAULT 0,
      cover_hash TEXT,
      FOREIGN KEY(folder_id) REFERENCES folders(id)
    );`,
  `CREATE TABLE IF NOT EXISTS playlists (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      created_at TEXT DEFAULT CURRENT_TIMESTAMP NOT NULL,
      updated_at TEXT DEFAULT CURRENT_TIMESTAMP NOT NULL
    );`,
  `CREATE TABLE IF NOT EXISTS playlist_tracks (
      playlist_id INTEGER NOT NULL,
      track_id INTEGER NOT NULL,
      position INTEGER NOT NULL,
      PRIMARY KEY (playlist_id, position),
      FOREIGN KEY(playlist_id) REFERENCES playlists(id) ON DELETE CASCADE,
      FOREIGN KEY(track_id) REFERENCES tracks(id) ON DELETE CASCADE
    );`,
  `CREATE INDEX IF NOT EXISTS idx_tracks_title ON tracks(title);`,
  `CREATE INDEX IF NOT EXISTS idx_tracks_artist ON tracks(artist);`,
  `CREATE INDEX IF NOT EXISTS idx_tracks_folder ON tracks(folder_id);`,
  `CREATE INDEX IF NOT EXISTS idx_albums_title ON albums(title);`,
  `CREATE INDEX IF NOT EXISTS idx_artists_name ON artists(name);`
];

export const getDatabase = (): SqliteDatabase => {
  if (db) {
    return db;
  }

  const userData = app.getPath('userData');
  const dbPath = path.join(userData, DB_FILE_NAME);
  db = new Database(dbPath);
  db.pragma('journal_mode = WAL');
  db.pragma('synchronous = NORMAL');

  const migrate = db.transaction(() => {
    for (const step of MIGRATION_STEPS) {
      db!.prepare(step).run();
    }
  });

  migrate();
  log.info('Database ready at %s', dbPath);
  return db;
};

export const insertFolder = (folderPath: string) => {
  const database = getDatabase();
  database
    .prepare(
      `INSERT OR IGNORE INTO folders(path, include) VALUES (@path, 1)`
    )
    .run({ path: folderPath });
};

export const listFolders = (): { id: number; path: string }[] => {
  return getDatabase()
    .prepare(`SELECT id, path FROM folders WHERE include = 1`)
    .all() as { id: number; path: string }[];
};

export const upsertTrack = (
  track: Omit<TrackRecord, 'id' | 'added_at'> & { added_at?: string }
): { id: number; inserted: boolean } => {
  const database = getDatabase();
  const insert = database.prepare(
    `INSERT INTO tracks(
        path, title, artist, album, track_no, disc_no, duration, bitrate, sample_rate, channels,
        format, genre, year, added_at, folder_id, has_lrc, cover_hash
      ) VALUES (@path, @title, @artist, @album, @track_no, @disc_no, @duration, @bitrate, @sample_rate,
        @channels, @format, @genre, @year, COALESCE(@added_at, CURRENT_TIMESTAMP), @folder_id, @has_lrc, @cover_hash)
      ON CONFLICT(path) DO UPDATE SET
        title = excluded.title,
        artist = excluded.artist,
        album = excluded.album,
        track_no = excluded.track_no,
        disc_no = excluded.disc_no,
        duration = excluded.duration,
        bitrate = excluded.bitrate,
        sample_rate = excluded.sample_rate,
        channels = excluded.channels,
        format = excluded.format,
        genre = excluded.genre,
        year = excluded.year,
        folder_id = excluded.folder_id,
        has_lrc = excluded.has_lrc,
        cover_hash = excluded.cover_hash
      `
  );
  const result = insert.run(track);
  const inserted = Number(result.changes) === 1 && Number(result.lastInsertRowid) !== 0;
  const id = inserted
    ? Number(result.lastInsertRowid)
    : (database.prepare(`SELECT id FROM tracks WHERE path = ?`).get(track.path) as { id: number }).id;
  return { id, inserted };
};

export const removeTracksNotInPaths = (folderId: number, validPaths: string[]) => {
  const database = getDatabase();
  const placeholders = validPaths.map(() => '?').join(',');
  if (!placeholders) {
    database.prepare(`DELETE FROM tracks WHERE folder_id = ?`).run(folderId);
    return;
  }
  database
    .prepare(`DELETE FROM tracks WHERE folder_id = ? AND path NOT IN (${placeholders})`)
    .run(folderId, ...validPaths);
};

export const fetchTrackById = (id: number): TrackRecord | undefined => {
  return getDatabase()
    .prepare(`SELECT * FROM tracks WHERE id = ?`)
    .get(id) as TrackRecord | undefined;
};

export const fetchTrackPath = (id: number): string | undefined => {
  const result = getDatabase().prepare(`SELECT path FROM tracks WHERE id = ?`).get(id) as
    | { path: string }
    | undefined;
  return result?.path;
};

export const fetchLibrarySummary = (): LibrarySummary => {
  const database = getDatabase();
  const tracks = database.prepare(`SELECT COUNT(*) as count FROM tracks`).get() as { count: number };
  const artists = database.prepare(`SELECT COUNT(*) as count FROM artists`).get() as { count: number };
  const albums = database.prepare(`SELECT COUNT(*) as count FROM albums`).get() as { count: number };
  const playlists = database.prepare(`SELECT COUNT(*) as count FROM playlists`).get() as { count: number };
  return {
    tracks: tracks.count,
    artists: artists.count,
    albums: albums.count,
    playlists: playlists.count
  };
};

const mapOrder = (sortBy?: string): string => {
  switch (sortBy) {
    case 'artist':
      return 'artist';
    case 'album':
      return 'album';
    case 'duration':
      return 'duration';
    case 'added_at':
      return 'added_at';
    default:
      return 'title';
  }
};

export const queryTracks = (query: TrackListQuery): PaginatedResult<TrackRecord> => {
  const database = getDatabase();
  const limit = query.limit ?? 100;
  const offset = query.offset ?? 0;
  const params: Record<string, unknown> = {};
  const where: string[] = [];

  if (query.search) {
    where.push('(title LIKE @search OR artist LIKE @search OR album LIKE @search)');
    params.search = `%${query.search}%`;
  }

  if (query.folderIds?.length) {
    where.push(`folder_id IN (${query.folderIds.map((_, i) => `@folder${i}`).join(',')})`);
    query.folderIds.forEach((folderId, index) => {
      params[`folder${index}`] = folderId;
    });
  }

  if (query.filters?.genre) {
    where.push('genre = @genre');
    params.genre = query.filters.genre;
  }

  if (query.filters?.format?.length) {
    where.push(`format IN (${query.filters.format.map((_, i) => `@format${i}`).join(',')})`);
    query.filters.format.forEach((format, index) => {
      params[`format${index}`] = format;
    });
  }

  let base = 'FROM tracks';
  if (query.playlistId) {
    base = 'FROM tracks INNER JOIN playlist_tracks pt ON tracks.id = pt.track_id WHERE pt.playlist_id = @playlistId';
    params.playlistId = query.playlistId;
    if (where.length) {
      base += ' AND ' + where.join(' AND ');
    }
  } else if (where.length) {
    base += ' WHERE ' + where.join(' AND ');
  }

  const order = mapOrder(query.sortBy);
  const direction = query.sortDirection === 'desc' ? 'DESC' : 'ASC';

  const items = database
    .prepare(`SELECT * ${base} ORDER BY ${order} COLLATE NOCASE ${direction} LIMIT @limit OFFSET @offset`)
    .all({ ...params, limit, offset }) as TrackRecord[];

  const totalRow = database.prepare(`SELECT COUNT(*) as total ${base}`).get(params) as { total: number };

  return {
    items,
    total: totalRow.total,
    limit,
    offset
  };
};

export const listAlbums = (search?: string): AlbumRecord[] => {
  const database = getDatabase();
  if (search) {
    return database
      .prepare(`SELECT * FROM albums WHERE title LIKE @search ORDER BY title COLLATE NOCASE ASC LIMIT 200`)
      .all({ search: `%${search}%` }) as AlbumRecord[];
  }
  return database.prepare(`SELECT * FROM albums ORDER BY title COLLATE NOCASE ASC LIMIT 200`).all() as AlbumRecord[];
};

export const listArtists = (search?: string): ArtistRecord[] => {
  const database = getDatabase();
  if (search) {
    return database
      .prepare(`SELECT * FROM artists WHERE name LIKE @search ORDER BY name COLLATE NOCASE ASC LIMIT 200`)
      .all({ search: `%${search}%` }) as ArtistRecord[];
  }
  return database.prepare(`SELECT * FROM artists ORDER BY name COLLATE NOCASE ASC LIMIT 200`).all() as ArtistRecord[];
};

export const listPlaylists = (): PlaylistWithTracks[] => {
  const database = getDatabase();
  const playlists = database.prepare(`SELECT * FROM playlists ORDER BY updated_at DESC`).all() as PlaylistRecord[];
  const statement = database.prepare(`SELECT tracks.* FROM tracks INNER JOIN playlist_tracks pt ON tracks.id = pt.track_id WHERE pt.playlist_id = ? ORDER BY pt.position ASC`);
  return playlists.map((playlist) => ({
    ...playlist,
    tracks: statement.all(playlist.id) as TrackRecord[]
  }));
};

export const upsertArtist = (name: string | null | undefined) => {
  if (!name) {
    return;
  }
  getDatabase().prepare(`INSERT OR IGNORE INTO artists(name) VALUES (?)`).run(name);
};

export const upsertAlbum = (title: string | null | undefined, artist: string | null | undefined, year: number | null | undefined, coverHash: string | null | undefined) => {
  if (!title) {
    return;
  }
  getDatabase()
    .prepare(
      `INSERT OR REPLACE INTO albums(title, artist, year, cover_hash) VALUES (@title, @artist, @year, @cover_hash)`
    )
    .run({ title, artist, year, cover_hash: coverHash ?? null });
};

export const savePlaylist = (playlist: PlaylistRecord, tracks: PlaylistTrackRecord[]) => {
  const database = getDatabase();
  const update = database.prepare(`UPDATE playlists SET name = @name, updated_at = CURRENT_TIMESTAMP WHERE id = @id`);
  const clear = database.prepare(`DELETE FROM playlist_tracks WHERE playlist_id = ?`);
  const insert = database.prepare(
    `INSERT INTO playlist_tracks(playlist_id, track_id, position) VALUES (@playlist_id, @track_id, @position)`
  );

  const transaction = database.transaction(() => {
    update.run(playlist);
    clear.run(playlist.id);
    for (const item of tracks) {
      insert.run(item);
    }
  });

  transaction();
};

export const insertPlaylist = (name: string): number => {
  const result = getDatabase().prepare(`INSERT INTO playlists(name) VALUES (?)`).run(name);
  return Number(result.lastInsertRowid);
};

export const deletePlaylist = (id: number) => {
  getDatabase().prepare(`DELETE FROM playlists WHERE id = ?`).run(id);
};

export const recordScanResult = (result: ScanResult) => {
  log.info('Scan completed: %o', result);
};
