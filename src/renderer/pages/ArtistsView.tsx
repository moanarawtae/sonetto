import { useEffect } from 'react';
import { useLibraryStore } from '../state/libraryStore';
import { ArtistGrid } from '../components/ArtistGrid';

export const ArtistsView = () => {
  const { artists, loadArtists } = useLibraryStore();

  useEffect(() => {
    void loadArtists();
  }, [loadArtists]);

  return (
    <div className="rounded-lg border border-slate-200 bg-white/80 p-6 dark:border-slate-800 dark:bg-slate-900/60">
      <ArtistGrid artists={artists} />
    </div>
  );
};
