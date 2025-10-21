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
  playPause: ['Space'],
  next: ['Control+ArrowRight', 'Meta+ArrowRight'],
  previous: ['Control+ArrowLeft', 'Meta+ArrowLeft'],
  seekForward: ['Alt+ArrowRight'],
  seekBackward: ['Alt+ArrowLeft'],
  volumeUp: ['Control+ArrowUp', 'Meta+ArrowUp'],
  volumeDown: ['Control+ArrowDown', 'Meta+ArrowDown'],
  search: ['Control+KeyF', 'Meta+KeyF'],
  focusLibrary: ['Control+KeyL', 'Meta+KeyL']
} as const;
