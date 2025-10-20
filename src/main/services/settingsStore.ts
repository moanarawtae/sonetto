import fs from 'node:fs';
import path from 'node:path';
import { app } from 'electron';
import { DEFAULT_SETTINGS } from '../../common/constants';
import type { SettingsSnapshot } from '../../common/types';
import { log } from './logger';

const SETTINGS_FILE = 'settings.json';

const getSettingsPath = () => path.join(app.getPath('userData'), SETTINGS_FILE);

export const loadSettings = (): SettingsSnapshot => {
  try {
    const file = fs.readFileSync(getSettingsPath(), 'utf8');
    const parsed = JSON.parse(file) as SettingsSnapshot;
    return {
      theme: parsed.theme ?? DEFAULT_SETTINGS.theme,
      hideUnsupported: parsed.hideUnsupported ?? DEFAULT_SETTINGS.hideUnsupported,
      monitoredFolders: parsed.monitoredFolders ?? []
    };
  } catch (error) {
    log.warn('Using default settings: %s', (error as Error).message);
    return { ...DEFAULT_SETTINGS, monitoredFolders: [] };
  }
};

export const saveSettings = (settings: Partial<SettingsSnapshot>): SettingsSnapshot => {
  const current = loadSettings();
  const merged: SettingsSnapshot = {
    theme: settings.theme ?? current.theme,
    hideUnsupported: settings.hideUnsupported ?? current.hideUnsupported,
    monitoredFolders: settings.monitoredFolders ?? current.monitoredFolders
  };
  fs.mkdirSync(path.dirname(getSettingsPath()), { recursive: true });
  fs.writeFileSync(getSettingsPath(), JSON.stringify(merged, null, 2));
  return merged;
};
