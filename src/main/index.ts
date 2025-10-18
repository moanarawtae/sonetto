import path from 'node:path';
import { pathToFileURL } from 'node:url';
import { app, BrowserWindow, dialog, ipcMain, nativeTheme } from 'electron';

const createWindow = async () => {
  const mainWindow = new BrowserWindow({
    width: 1280,
    height: 800,
    minWidth: 960,
    minHeight: 640,
    backgroundColor: nativeTheme.shouldUseDarkColors ? '#020617' : '#f8fafc',
    show: false,
    webPreferences: {
      preload: path.join(__dirname, '../preload/index.js'),
      contextIsolation: true,
      nodeIntegration: false,
      spellcheck: false
    }
  });

  if (process.env.VITE_DEV_SERVER_URL) {
    await mainWindow.loadURL(process.env.VITE_DEV_SERVER_URL);
    mainWindow.webContents.openDevTools({ mode: 'detach' });
  } else {
    const rendererPath = path.join(app.getAppPath(), 'dist/renderer/index.html');
    await mainWindow.loadFile(rendererPath);
  }

  mainWindow.once('ready-to-show', () => {
    mainWindow.show();
  });
};

const registerIpcHandlers = () => {
  ipcMain.handle('dialog:select-audio', async () => {
    const result = await dialog.showOpenDialog({
      properties: ['openFile'],
      filters: [
        {
          name: 'Áudio',
          extensions: ['mp3', 'm4a', 'aac', 'ogg', 'wav', 'flac']
        }
      ]
    });

    if (result.canceled || result.filePaths.length === 0) {
      return undefined;
    }

    const filePath = result.filePaths[0];
    return pathToFileURL(filePath).toString();
  });

  ipcMain.handle('theme:get', () => {
    const theme = nativeTheme.themeSource ?? 'system';
    if (theme === 'system') {
      return nativeTheme.shouldUseDarkColors ? 'dark' : 'light';
    }
    return theme;
  });

  ipcMain.on('theme:set', (_, theme: 'light' | 'dark') => {
    nativeTheme.themeSource = theme;
  });
};

app.whenReady().then(() => {
  registerIpcHandlers();
  void createWindow();

  app.on('activate', () => {
    if (BrowserWindow.getAllWindows().length === 0) {
      void createWindow();
    }
  });
});

app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') {
    app.quit();
  }
});
