import { useEffect } from 'react';
import { useLibraryStore } from '../state/libraryStore';
import { AlbumGrid } from '../components/AlbumGrid';

export const AlbumsView = () => {
  const { albums, loadAlbums } = useLibraryStore();

  useEffect(() => {
    void loadAlbums();
  }, [loadAlbums]);

  return (
    <div className="rounded-lg border border-slate-200 bg-white/80 p-6 dark:border-slate-800 dark:bg-slate-900/60">
      <AlbumGrid albums={albums} />
    </div>
  );
};
