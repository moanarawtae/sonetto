export type AudioFormat = 'mp3' | 'm4a' | 'aac' | 'ogg' | 'wav' | 'flac';

export interface FolderRecord {
  id: number;
  path: string;
  include: number;
  added_at: string;
}

export interface TrackRecord {
  id: number;
  path: string;
  title: string;
  artist: string | null;
  album: string | null;
  track_no: number | null;
  disc_no: number | null;
  duration: number | null;
  bitrate: number | null;
  sample_rate: number | null;
  channels: number | null;
  format: AudioFormat;
  genre: string | null;
  year: number | null;
  added_at: string;
  folder_id: number | null;
  has_lrc: number;
  cover_hash: string | null;
}

export interface AlbumRecord {
  id: number;
  title: string;
  artist: string | null;
  year: number | null;
  cover_hash: string | null;
}

export interface ArtistRecord {
  id: number;
  name: string;
}

export interface PlaylistRecord {
  id: number;
  name: string;
  created_at: string;
  updated_at: string;
}

export interface PlaylistTrackRecord {
  playlist_id: number;
  track_id: number;
  position: number;
}

export interface LibrarySummary {
  tracks: number;
  artists: number;
  albums: number;
  playlists: number;
}

export interface ScanProgressPayload {
  processed: number;
  total: number;
  currentPath?: string;
}

export interface ScanResult {
  foldersScanned: number;
  tracksImported: number;
  tracksUpdated: number;
  durationMs: number;
}

export interface TrackListQuery {
  search?: string;
  folderIds?: number[];
  playlistId?: number;
  limit?: number;
  offset?: number;
  sortBy?: 'title' | 'artist' | 'album' | 'duration' | 'added_at';
  sortDirection?: 'asc' | 'desc';
  filters?: {
    genre?: string;
    format?: AudioFormat[];
  };
}

export interface PaginatedResult<T> {
  items: T[];
  total: number;
  limit: number;
  offset: number;
}

export interface PlaylistWithTracks extends PlaylistRecord {
  tracks: TrackRecord[];
}

export type ThemePreference = 'system' | 'light' | 'dark';

export interface SettingsSnapshot {
  theme: ThemePreference;
  monitoredFolders: string[];
  hideUnsupported: boolean;
}

export interface PlayerStateSnapshot {
  trackId: number | null;
  position: number;
  duration: number;
  isPlaying: boolean;
  volume: number;
  repeat: 'none' | 'track' | 'all';
  shuffle: boolean;
  queue: number[];
  history: number[];
}

export interface CoverArtPayload {
  hash: string;
  path: string;
  averageColor: string | null;
}

export interface RendererBridge {
  library: {
    scan: (paths: string[]) => Promise<ScanResult>;
    onScanProgress: (listener: (progress: ScanProgressPayload) => void) => () => void;
    fetchTracks: (query: TrackListQuery) => Promise<PaginatedResult<TrackRecord>>;
    fetchAlbums: (search?: string) => Promise<AlbumRecord[]>;
    fetchArtists: (search?: string) => Promise<ArtistRecord[]>;
    fetchPlaylists: () => Promise<PlaylistWithTracks[]>;
    getSummary: () => Promise<LibrarySummary>;
    getTrack: (id: number) => Promise<TrackRecord | null>;
    getCoverArt: (hash: string) => Promise<CoverArtPayload | null>;
  };
  player: {
    resolveTrackPath: (trackId: number) => Promise<string>;
    ensureFormats: () => Promise<{ supported: AudioFormat[]; unsupported: AudioFormat[] }>;
  };
  settings: {
    selectFolders: () => Promise<string[]>;
    getSettings: () => Promise<SettingsSnapshot>;
    updateSettings: (settings: Partial<SettingsSnapshot>) => Promise<SettingsSnapshot>;
  };
  app: {
    getVersion: () => Promise<string>;
    openExternal: (url: string) => Promise<void>;
  };
}

declare global {
  interface Window {
    sonetto: RendererBridge;
  }
}
