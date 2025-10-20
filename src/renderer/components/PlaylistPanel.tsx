import type { PlaylistWithTracks } from '../../common/types';
import { usePlayerStore } from '../state/playerStore';

interface PlaylistPanelProps {
  playlists: PlaylistWithTracks[];
}

export const PlaylistPanel = ({ playlists }: PlaylistPanelProps) => {
  const { loadQueue } = usePlayerStore();
  return (
    <div className="space-y-4">
      {playlists.map((playlist) => (
        <section
          key={playlist.id}
          className="rounded-lg border border-slate-200 bg-white/70 p-4 shadow-sm dark:border-slate-800 dark:bg-slate-900/60"
        >
          <div className="mb-3 flex items-center justify-between">
            <div>
              <h3 className="text-sm font-semibold text-slate-800 dark:text-slate-100">{playlist.name}</h3>
              <p className="text-xs text-slate-500 dark:text-slate-400">
                {playlist.tracks.length} faixas
              </p>
            </div>
            <button
              type="button"
              onClick={() => loadQueue(playlist.tracks, 0)}
              className="rounded-md bg-sky-500 px-3 py-1 text-xs font-semibold text-white transition hover:bg-sky-600 focus:outline-none focus-visible:ring-2 focus-visible:ring-sky-400"
            >
              Reproduzir
            </button>
          </div>
          <ul className="space-y-2">
            {playlist.tracks.slice(0, 5).map((track) => (
              <li key={track.id} className="flex items-center justify-between text-xs text-slate-600 dark:text-slate-300">
                <span className="truncate">{track.title}</span>
                <span className="truncate text-slate-400">{track.artist}</span>
              </li>
            ))}
            {playlist.tracks.length > 5 && (
              <li className="text-xs italic text-slate-400">e mais {playlist.tracks.length - 5} faixas...</li>
            )}
          </ul>
        </section>
      ))}
    </div>
  );
};
