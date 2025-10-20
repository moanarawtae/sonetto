import { dialog, ipcMain, nativeTheme } from 'electron';
import { IPC_CHANNELS } from '../../common/ipc';
import type {
  ScanProgressPayload,
  TrackListQuery
} from '../../common/types';
import { fetchLibrarySummary, fetchTrackById, listAlbums, listArtists, listPlaylists, queryTracks } from '../services/database';
import { computeAverageColor, resolveCoverArt, scanLibrary } from '../services/libraryScanner';
import { startWatching } from '../services/folderWatcher';
import { loadSettings, saveSettings } from '../services/settingsStore';
import { log } from '../services/logger';

export const registerLibraryHandlers = () => {
  ipcMain.handle(IPC_CHANNELS.LIBRARY_SCAN, async (event, folders: string[]) => {
    const webContents = event.sender;
    const onProgress = (payload: ScanProgressPayload) => {
      webContents.send(IPC_CHANNELS.LIBRARY_SCAN_PROGRESS, payload);
    };
    const result = await scanLibrary(folders, { onProgress });
    log.info('Scan finished: %o', result);
    return result;
  });

  ipcMain.handle(IPC_CHANNELS.LIBRARY_FETCH_TRACKS, (_, query: TrackListQuery) => {
    return queryTracks(query);
  });

  ipcMain.handle(IPC_CHANNELS.LIBRARY_FETCH_ALBUMS, (_, search?: string) => {
    return listAlbums(search);
  });

  ipcMain.handle(IPC_CHANNELS.LIBRARY_FETCH_ARTISTS, (_, search?: string) => {
    return listArtists(search);
  });

  ipcMain.handle(IPC_CHANNELS.LIBRARY_FETCH_PLAYLISTS, () => {
    return listPlaylists();
  });

  ipcMain.handle(IPC_CHANNELS.LIBRARY_GET_SUMMARY, () => {
    return fetchLibrarySummary();
  });

  ipcMain.handle(IPC_CHANNELS.LIBRARY_GET_TRACK, (_, id: number) => {
    return fetchTrackById(id) ?? null;
  });

  ipcMain.handle(IPC_CHANNELS.LIBRARY_GET_COVER, async (_, hash: string) => {
    const [averageColor, coverPath] = await Promise.all([
      computeAverageColor(hash),
      resolveCoverArt(hash)
    ]);
    if (!coverPath) {
      return null;
    }
    return {
      hash,
      path: coverPath,
      averageColor
    };
  });

  ipcMain.handle(IPC_CHANNELS.SETTINGS_SELECT_FOLDERS, async () => {
    const result = await dialog.showOpenDialog({
      properties: ['openDirectory', 'multiSelections']
    });
    if (result.canceled) {
      return [];
    }
    return result.filePaths;
  });

  ipcMain.handle(IPC_CHANNELS.SETTINGS_GET, () => {
    return loadSettings();
  });

  ipcMain.handle(IPC_CHANNELS.SETTINGS_UPDATE, (_, settings) => {
    const snapshot = saveSettings(settings);
    if (settings?.theme && settings.theme !== 'system') {
      nativeTheme.themeSource = settings.theme;
    } else if (settings?.theme === 'system') {
      nativeTheme.themeSource = 'system';
    }
    startWatching(snapshot.monitoredFolders);
    return snapshot;
  });
};
