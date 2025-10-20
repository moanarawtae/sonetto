import { useEffect } from 'react';
import { useSettingsStore } from '../state/settingsStore';

const applyTheme = (theme: 'light' | 'dark') => {
  const root = document.documentElement;
  if (theme === 'dark') {
    root.classList.add('dark');
  } else {
    root.classList.remove('dark');
  }
};

export const useTheme = () => {
  const { theme, load } = useSettingsStore();

  useEffect(() => {
    void load();
  }, [load]);

  useEffect(() => {
    if (theme === 'system') {
      applyTheme(window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light');
    } else {
      applyTheme(theme);
    }
  }, [theme]);
};
