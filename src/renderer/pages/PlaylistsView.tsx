import { useEffect } from 'react';
import { useLibraryStore } from '../state/libraryStore';
import { PlaylistPanel } from '../components/PlaylistPanel';

export const PlaylistsView = () => {
  const { playlists, loadPlaylists } = useLibraryStore();

  useEffect(() => {
    void loadPlaylists();
  }, [loadPlaylists]);

  return (
    <div className="rounded-lg border border-slate-200 bg-white/80 p-6 dark:border-slate-800 dark:bg-slate-900/60">
      <PlaylistPanel playlists={playlists} />
    </div>
  );
};
