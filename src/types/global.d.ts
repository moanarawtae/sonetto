export interface SonettoTrack {
  id: string;
  title: string;
  artist: string;
  duration: number;
  path: string;
  coverUri?: string;
}

declare global {
  interface Window {
    sonetto: {
      selectAudioFile: () => Promise<string | undefined>;
      toggleTheme: (theme: 'light' | 'dark') => void;
      getTheme: () => Promise<'light' | 'dark'>;
    };
  }
}

export {};
