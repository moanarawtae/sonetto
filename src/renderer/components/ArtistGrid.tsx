import type { ArtistRecord } from '../../common/types';

interface ArtistGridProps {
  artists: ArtistRecord[];
}

export const ArtistGrid = ({ artists }: ArtistGridProps) => (
  <div className="grid grid-cols-2 gap-4 md:grid-cols-3 lg:grid-cols-4 xl:grid-cols-5">
    {artists.map((artist) => (
      <article
        key={artist.id}
        className="rounded-lg border border-slate-200 bg-white/60 p-4 text-center shadow-sm transition hover:-translate-y-1 hover:border-sky-500 hover:shadow-lg dark:border-slate-800 dark:bg-slate-900/60"
      >
        <div className="mx-auto mb-3 h-20 w-20 rounded-full bg-slate-200 dark:bg-slate-800" />
        <h3 className="truncate text-sm font-semibold text-slate-800 dark:text-slate-100">{artist.name}</h3>
      </article>
    ))}
  </div>
);
