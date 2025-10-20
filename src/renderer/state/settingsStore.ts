import { create } from 'zustand';
import type { SettingsSnapshot, ThemePreference } from '../../common/types';

interface SettingsState extends SettingsSnapshot {
  initialized: boolean;
  load: () => Promise<void>;
  update: (payload: Partial<SettingsSnapshot>) => Promise<void>;
  setTheme: (theme: ThemePreference) => Promise<void>;
}

export const useSettingsStore = create<SettingsState>((set, _get) => ({
  theme: 'system',
  hideUnsupported: false,
  monitoredFolders: [],
  initialized: false,
  load: async () => {
    const settings = await window.sonetto.settings.getSettings();
    set({ ...settings, initialized: true });
  },
  update: async (payload) => {
    const updated = await window.sonetto.settings.updateSettings(payload);
    set(updated);
  },
  setTheme: async (theme) => {
    const updated = await window.sonetto.settings.updateSettings({ theme });
    set(updated);
  }
}));
