import path from 'node:path';
import { app, BrowserWindow, nativeTheme } from 'electron';
import { registerLibraryHandlers } from './ipc/libraryHandlers';
import { registerPlayerHandlers } from './ipc/playerHandlers';
import { startWatching } from './services/folderWatcher';
import { getDatabase, listFolders } from './services/database';
import { loadSettings } from './services/settingsStore';
import { log } from './services/logger';

const isDevelopment = process.env.VITE_DEV_SERVER_URL !== undefined;

const createWindow = async () => {
  const window = new BrowserWindow({
    width: 1320,
    height: 840,
    minWidth: 1024,
    minHeight: 700,
    backgroundColor: nativeTheme.shouldUseDarkColors ? '#020617' : '#f8fafc',
    title: 'Sonetto',
    webPreferences: {
      preload: path.join(__dirname, '../preload/index.cjs'),
      contextIsolation: true,
      nodeIntegration: false,
      spellcheck: false
    }
  });

  if (isDevelopment && process.env.VITE_DEV_SERVER_URL) {
    await window.loadURL(process.env.VITE_DEV_SERVER_URL);
    window.webContents.openDevTools({ mode: 'detach' });
  } else {
    await window.loadFile(path.join(app.getAppPath(), 'dist/renderer/index.html'));
  }

  return window;
};

const bootstrap = async () => {
  await app.whenReady();
  getDatabase();
  registerLibraryHandlers();
  registerPlayerHandlers();

  const settings = loadSettings();
  if (settings.theme !== 'system') {
    nativeTheme.themeSource = settings.theme;
  }

  const win = await createWindow();
  win.once('ready-to-show', () => {
    win.show();
  });

  const folders = listFolders().map((folder) => folder.path);
  if (folders.length) {
    startWatching(folders);
  }

  app.on('activate', async () => {
    if (BrowserWindow.getAllWindows().length === 0) {
      await createWindow();
    }
  });
};

app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') {
    app.quit();
  }
});

bootstrap().catch((error) => {
  log.error(
    'Failed to bootstrap app: %s',
    (error as Error).stack ?? (error as Error).message
  );
});
