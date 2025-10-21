import { useCallback, useEffect } from 'react';
import { Navigate, Route, Routes, useLocation, useNavigate } from 'react-router-dom';
import { SidebarNav } from './components/SidebarNav';
import { TopBar } from './components/TopBar';
import { NowPlayingBar } from './components/NowPlayingBar';
import { AudioEngine } from './components/AudioEngine';
import { HomeView } from './pages/HomeView';
import { TracksView } from './pages/TracksView';
import { AlbumsView } from './pages/AlbumsView';
import { ArtistsView } from './pages/ArtistsView';
import { PlaylistsView } from './pages/PlaylistsView';
import { SettingsView } from './pages/SettingsView';
import { useLibraryStore } from './state/libraryStore';
import { useSettingsStore } from './state/settingsStore';
import { useTheme } from './hooks/useTheme';
import { useKeyboardShortcuts } from './hooks/useKeyboardShortcuts';
import { bridge } from './bridge';

const App = () => {
  const loadTracks = useLibraryStore((state) => state.loadTracks);
  const query = useLibraryStore((state) => state.query);
  const setScanning = useLibraryStore((state) => state.setScanning);
  const setScanProgress = useLibraryStore((state) => state.setScanProgress);
  const updateSettings = useSettingsStore((state) => state.update);
  const location = useLocation();
  const navigate = useNavigate();

  useTheme();
  useKeyboardShortcuts();

  useEffect(() => {
    const unsubscribe = bridge.library.onScanProgress((payload) => {
      setScanProgress(payload);
    });
    return () => {
      unsubscribe();
    };
  }, [setScanProgress]);

  const handleSearch = useCallback(
    (term: string) => {
      void loadTracks({ ...query, search: term, offset: 0 });
      if (!location.pathname.includes('/library')) {
        navigate('/library/tracks');
      }
    },
    [loadTracks, location.pathname, navigate, query]
  );

  const handleAddFolder = useCallback(async () => {
    const folders = await bridge.settings.selectFolders();
    if (folders.length) {
      const current = useSettingsStore.getState().monitoredFolders;
      const merged = [...new Set([...current, ...folders])];
      await updateSettings({ monitoredFolders: merged });
      setScanning(true);
      const result = await bridge.library.scan(folders);
      setScanning(false);
      if (result.tracksImported > 0) {
        await loadTracks(query);
      }
    }
  }, [loadTracks, query, setScanning, updateSettings]);

  return (
    <div className="flex h-screen flex-col bg-slate-100 text-slate-900 antialiased dark:bg-slate-950 dark:text-slate-100">
      <div className="flex flex-1 overflow-hidden">
        <SidebarNav />
        <div className="flex flex-1 flex-col overflow-hidden">
          <TopBar onSearch={handleSearch} onAddFolder={handleAddFolder} />
          <main className="flex-1 overflow-y-auto bg-gradient-to-br from-white via-slate-50 to-slate-100 p-6 dark:from-slate-950 dark:via-slate-900 dark:to-slate-900">
            <div className="mx-auto flex h-full max-w-7xl flex-col space-y-6">
              <Routes>
                <Route path="/" element={<Navigate to="/library" replace />} />
                <Route path="/library" element={<HomeView />} />
                <Route path="/library/tracks" element={<TracksView />} />
                <Route path="/library/albums" element={<AlbumsView />} />
                <Route path="/library/artists" element={<ArtistsView />} />
                <Route path="/library/playlists" element={<PlaylistsView />} />
                <Route path="/settings" element={<SettingsView />} />
                <Route path="*" element={<Navigate to="/library" replace />} />
              </Routes>
            </div>
          </main>
          <NowPlayingBar onExpand={() => undefined} />
        </div>
      </div>
      <AudioEngine />
    </div>
  );
};

export default App;
