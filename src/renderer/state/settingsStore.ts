import { create } from 'zustand';
import type { SettingsSnapshot, ThemePreference } from '../../common/types';
import { bridge } from '../bridge';

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
    const settings = await bridge.settings.getSettings();
    set((state) => ({ ...state, ...settings, initialized: true }));
  },
  update: async (payload) => {
    const updated = await bridge.settings.updateSettings(payload);
    set((state) => ({ ...state, ...updated }));
  },
  setTheme: async (theme) => {
    const updated = await bridge.settings.updateSettings({ theme });
    set((state) => ({ ...state, ...updated }));
  }
}));
