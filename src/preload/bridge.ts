import { contextBridge, ipcRenderer, shell } from 'electron';
import { IPC_CHANNELS } from '../common/ipc';
import type {
  AudioFormat,
  RendererBridge,
  ScanProgressPayload,
  TrackListQuery
} from '../common/types';
import { SUPPORTED_AUDIO_FORMATS, REQUIRED_AUDIO_FORMAT } from '../common/constants';

const detectFormats = () => {
  const audio = new globalThis.Audio();
  const supported: AudioFormat[] = [];
  const unsupported: AudioFormat[] = [];

  for (const format of SUPPORTED_AUDIO_FORMATS) {
    const mime = format === 'mp3' ? 'audio/mpeg' : `audio/${format}`;
    const verdict = audio.canPlayType(mime);

    if (verdict === 'probably' || verdict === 'maybe') {
      supported.push(format);
    } else {
      unsupported.push(format);
    }
  }

  if (!supported.includes(REQUIRED_AUDIO_FORMAT)) {
    supported.push(REQUIRED_AUDIO_FORMAT);
  }

  return {
    supported,
    unsupported: unsupported.filter((format) => format !== REQUIRED_AUDIO_FORMAT)
  };
};

export const bridge: RendererBridge = {
  library: {
    scan: (paths) => ipcRenderer.invoke(IPC_CHANNELS.LIBRARY_SCAN, paths),
    onScanProgress: (listener) => {
      const handler = (_: unknown, payload: ScanProgressPayload) => listener(payload);
      ipcRenderer.on(IPC_CHANNELS.LIBRARY_SCAN_PROGRESS, handler);
      return () => ipcRenderer.removeListener(IPC_CHANNELS.LIBRARY_SCAN_PROGRESS, handler);
    },
    fetchTracks: (query: TrackListQuery) => ipcRenderer.invoke(IPC_CHANNELS.LIBRARY_FETCH_TRACKS, query),
    fetchAlbums: (search?: string) => ipcRenderer.invoke(IPC_CHANNELS.LIBRARY_FETCH_ALBUMS, search),
    fetchArtists: (search?: string) => ipcRenderer.invoke(IPC_CHANNELS.LIBRARY_FETCH_ARTISTS, search),
    fetchPlaylists: () => ipcRenderer.invoke(IPC_CHANNELS.LIBRARY_FETCH_PLAYLISTS),
    getSummary: () => ipcRenderer.invoke(IPC_CHANNELS.LIBRARY_GET_SUMMARY),
    getTrack: (id: number) => ipcRenderer.invoke(IPC_CHANNELS.LIBRARY_GET_TRACK, id),
    getCoverArt: (hash: string) => ipcRenderer.invoke(IPC_CHANNELS.LIBRARY_GET_COVER, hash)
  },
  player: {
    resolveTrackPath: (trackId: number) => ipcRenderer.invoke(IPC_CHANNELS.PLAYER_RESOLVE_TRACK, trackId),
    ensureFormats: async () => detectFormats()
  },
  settings: {
    selectFolders: () => ipcRenderer.invoke(IPC_CHANNELS.SETTINGS_SELECT_FOLDERS),
    getSettings: () => ipcRenderer.invoke(IPC_CHANNELS.SETTINGS_GET),
    updateSettings: (settings) => ipcRenderer.invoke(IPC_CHANNELS.SETTINGS_UPDATE, settings)
  },
  app: {
    getVersion: () => ipcRenderer.invoke(IPC_CHANNELS.APP_GET_VERSION),
    openExternal: (url: string) => shell.openExternal(url)
  }
};

export const exposeBridge = () => {
  contextBridge.exposeInMainWorld('sonetto', bridge);
};

