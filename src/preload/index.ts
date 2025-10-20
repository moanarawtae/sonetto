import { contextBridge, ipcRenderer } from 'electron';

contextBridge.exposeInMainWorld('sonetto', {
  selectAudioFile: () => ipcRenderer.invoke('dialog:select-audio'),
  toggleTheme: (theme: 'light' | 'dark') => ipcRenderer.send('theme:set', theme),
  getTheme: () => ipcRenderer.invoke('theme:get')
});
