import { create } from 'zustand';
import type {
  AlbumRecord,
  ArtistRecord,
  PaginatedResult,
  PlaylistWithTracks,
  ScanProgressPayload,
  TrackListQuery,
  TrackRecord
} from '../../common/types';
import { bridge } from '../bridge';

type ViewMode = 'albums' | 'artists' | 'tracks' | 'playlists';

interface LibraryState {
  tracks: TrackRecord[];
  albums: AlbumRecord[];
  artists: ArtistRecord[];
  playlists: PlaylistWithTracks[];
  totalTracks: number;
  loading: boolean;
  scanning: boolean;
  scanProgress?: ScanProgressPayload;
  query: TrackListQuery;
  view: ViewMode;
  loadTracks: (query: TrackListQuery) => Promise<void>;
  loadAlbums: (search?: string) => Promise<void>;
  loadArtists: (search?: string) => Promise<void>;
  loadPlaylists: () => Promise<void>;
  setView: (view: ViewMode) => void;
  setScanning: (value: boolean) => void;
  setScanProgress: (payload?: ScanProgressPayload) => void;
}

export const useLibraryStore = create<LibraryState>((set) => ({
  tracks: [],
  albums: [],
  artists: [],
  playlists: [],
  totalTracks: 0,
  loading: false,
  scanning: false,
  query: { limit: 100, offset: 0, sortBy: 'title', sortDirection: 'asc' },
  view: 'tracks',
  loadTracks: async (query) => {
    set({ loading: true, query });
    const result = (await bridge.library.fetchTracks(query)) as PaginatedResult<TrackRecord>;
    set({ tracks: result.items, totalTracks: result.total, loading: false });
  },
  loadAlbums: async (search) => {
    const albums = await bridge.library.fetchAlbums(search);
    set({ albums });
  },
  loadArtists: async (search) => {
    const artists = await bridge.library.fetchArtists(search);
    set({ artists });
  },
  loadPlaylists: async () => {
    const playlists = await bridge.library.fetchPlaylists();
    set({ playlists });
  },
  setView: (view) => set({ view }),
  setScanning: (value) => set({ scanning: value, scanProgress: value ? { processed: 0, total: 0 } : undefined }),
  setScanProgress: (payload) => set({ scanProgress: payload })
}));
