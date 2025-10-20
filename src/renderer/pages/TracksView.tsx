import { useEffect } from 'react';
import { useLibraryStore } from '../state/libraryStore';
import { TrackTable } from '../components/TrackTable';

export const TracksView = () => {
  const { tracks, loadTracks, query, loading } = useLibraryStore();

  useEffect(() => {
    void loadTracks(query);
  }, [loadTracks, query]);

  return (
    <div className="flex h-full flex-col">
      {loading && <p className="mb-2 text-xs text-slate-400">Carregando faixas...</p>}
      <div className="flex-1 overflow-hidden rounded-lg border border-slate-200 bg-white/80 dark:border-slate-800 dark:bg-slate-900/60">
        <TrackTable tracks={tracks} />
      </div>
    </div>
  );
};
