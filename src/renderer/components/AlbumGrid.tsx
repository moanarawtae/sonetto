import type { AlbumRecord } from '../../common/types';

interface AlbumGridProps {
  albums: AlbumRecord[];
}

export const AlbumGrid = ({ albums }: AlbumGridProps) => {
  return (
    <div className="grid grid-cols-2 gap-4 md:grid-cols-3 lg:grid-cols-4 xl:grid-cols-5">
      {albums.map((album) => (
        <article
          key={`${album.title}-${album.artist}`}
          className="group rounded-lg border border-slate-200 bg-white/70 p-4 shadow-sm transition hover:-translate-y-1 hover:border-sky-500 hover:shadow-lg focus-within:border-sky-500 dark:border-slate-800 dark:bg-slate-900/60"
        >
          <div className="mb-3 aspect-square w-full overflow-hidden rounded-md bg-gradient-to-br from-slate-200 to-slate-300 dark:from-slate-700 dark:to-slate-800" />
          <h3 className="truncate text-sm font-semibold text-slate-800 group-hover:text-sky-600 dark:text-slate-100">
            {album.title}
          </h3>
          <p className="truncate text-xs text-slate-500 dark:text-slate-400">{album.artist ?? 'Artista desconhecido'}</p>
          {album.year && <p className="text-xs text-slate-400">{album.year}</p>}
        </article>
      ))}
    </div>
  );
};
