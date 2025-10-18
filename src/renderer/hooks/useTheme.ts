import { useCallback, useEffect, useState } from 'react';

type ThemeMode = 'light' | 'dark';

export const useTheme = () => {
  const [theme, setTheme] = useState<ThemeMode>('light');

  const applyTheme = useCallback(
    (mode: ThemeMode) => {
      setTheme(mode);
      document.documentElement.classList.toggle('dark', mode === 'dark');
    },
    []
  );

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
  }, [applyTheme]);

  const toggleTheme = useCallback(() => {
    const next = theme === 'light' ? 'dark' : 'light';
    window.sonetto.toggleTheme(next);
    applyTheme(next);
  }, [applyTheme, theme]);

  return { theme, toggleTheme };
};
