import type { AudioFormat } from './types';

export const SUPPORTED_AUDIO_FORMATS: AudioFormat[] = [
  'mp3',
  'm4a',
  'aac',
  'ogg',
  'wav',
  'flac'
];

export const REQUIRED_AUDIO_FORMAT: AudioFormat = 'mp3';

export const COVER_CACHE_DIR = 'covers';

export const DB_FILE_NAME = 'library.db';

export const DEFAULT_SETTINGS = {
  theme: 'system' as const,
  hideUnsupported: false
};

export const PLAYBACK_SHORTCUTS = {
  PLAY_PAUSE: 'Space',
  NEXT_TRACK: 'Ctrl+ArrowRight',
  PREV_TRACK: 'Ctrl+ArrowLeft',
  SEARCH: 'Ctrl+KeyF',
  FOCUS_LIBRARY: 'Ctrl+KeyL',
  SEEK_FORWARD: 'Alt+ArrowRight',
  SEEK_BACKWARD: 'Alt+ArrowLeft',
  VOLUME_UP: 'Ctrl+ArrowUp',
  VOLUME_DOWN: 'Ctrl+ArrowDown'
};
