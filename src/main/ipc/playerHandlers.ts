import { app, ipcMain, shell } from 'electron';
import { pathToFileURL } from 'node:url';
import { IPC_CHANNELS } from '../../common/ipc';
import { fetchTrackPath } from '../services/database';

export const registerPlayerHandlers = () => {
  ipcMain.handle(IPC_CHANNELS.PLAYER_RESOLVE_TRACK, (_, trackId: number) => {
    const trackPath = fetchTrackPath(trackId);
    if (!trackPath) {
      return '';
    }
    return pathToFileURL(trackPath).toString();
  });

  ipcMain.handle(IPC_CHANNELS.APP_GET_VERSION, () => {
    return app.getVersion();
  });

  ipcMain.handle(IPC_CHANNELS.APP_OPEN_EXTERNAL, (_, url: string) => {
    return shell.openExternal(url);
  });
};
