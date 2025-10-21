import type {
  RendererBridge,
  SettingsSnapshot,
  TrackListQuery,
  PaginatedResult,
  TrackRecord
} from '../common/types';

const ensureLimit = (query: TrackListQuery): Required<Pick<TrackListQuery, 'limit' | 'offset'>> => ({
  limit: query.limit ?? 100,
  offset: query.offset ?? 0
});

let fallbackSettings: SettingsSnapshot = {
  theme: 'system',
  monitoredFolders: [],
  hideUnsupported: false
};

const emptyTracks: TrackRecord[] = [];

const fallbackBridge: RendererBridge = {
  library: {
    scan: async () => ({
      foldersScanned: 0,
      tracksImported: 0,
      tracksUpdated: 0,
      durationMs: 0
    }),
    onScanProgress: () => () => undefined,
    fetchTracks: async (query: TrackListQuery) => {
      const { limit, offset } = ensureLimit(query);
      const result: PaginatedResult<TrackRecord> = {
        items: emptyTracks,
        total: 0,
        limit,
        offset
      };
      return result;
    },
    fetchAlbums: async () => [],
    fetchArtists: async () => [],
    fetchPlaylists: async () => [],
    getSummary: async () => ({ tracks: 0, artists: 0, albums: 0, playlists: 0 }),
    getTrack: async () => null,
    getCoverArt: async () => null
  },
  player: {
    resolveTrackPath: async () => '',
    ensureFormats: async () => ({ supported: ['mp3'], unsupported: [] })
  },
  settings: {
    selectFolders: async () => [],
    getSettings: async () => fallbackSettings,
    updateSettings: async (settings: Partial<SettingsSnapshot>) => {
      fallbackSettings = { ...fallbackSettings, ...settings };
      return fallbackSettings;
    }
  },
  app: {
    getVersion: async () => 'dev-preview',
    openExternal: async (url: string) => {
      if (typeof window !== 'undefined') {
        window.open(url, '_blank', 'noopener,noreferrer');
      }
    }
  }
};

export const bridge: RendererBridge =
  typeof window !== 'undefined' && window.sonetto ? window.sonetto : fallbackBridge;

if (typeof window !== 'undefined' && !window.sonetto) {
  window.sonetto = bridge;
}
