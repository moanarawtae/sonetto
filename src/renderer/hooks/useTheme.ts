import { useEffect, useState } from 'react';

type ThemeMode = 'light' | 'dark';

export const useTheme = () => {
  const [theme, setTheme] = useState<ThemeMode>('light');

  useEffect(() => {
    let isMounted = true;
    window.sonetto
      .getTheme()
      .then((mode) => {
        if (!isMounted) return;
        applyTheme(mode);
      })
      .catch(() => applyTheme('light'));

    return () => {
      isMounted = false;
    };
  }, []);

  const applyTheme = (mode: ThemeMode) => {
    setTheme(mode);
    document.documentElement.classList.toggle('dark', mode === 'dark');
  };

  const toggleTheme = () => {
    const next = theme === 'light' ? 'dark' : 'light';
    window.sonetto.toggleTheme(next);
    applyTheme(next);
  };

  return { theme, toggleTheme };
};
