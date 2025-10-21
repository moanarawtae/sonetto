import { useCallback, useMemo } from 'react';
import type { MouseEvent } from 'react';
import { usePlayerStore } from '../state/playerStore';
import { formatTime } from '../utils/formatTime';

interface NowPlayingBarProps {
  onExpand: () => void;
}

export const NowPlayingBar = ({ onExpand }: NowPlayingBarProps) => {
  const {
    currentTrack,
    isPlaying,
    setIsPlaying,
    next,
    previous,
    position,
    duration,
    setPosition,
    shuffle,
    toggleShuffle,
    repeat,
    cycleRepeat,
    volume,
    setVolume
  } = usePlayerStore();

  const progress = useMemo(() => (duration ? (position / duration) * 100 : 0), [duration, position]);

  const handleSeek = useCallback(
    (event: MouseEvent<HTMLDivElement>) => {
      if (!duration) {
        return;
      }
      const rect = event.currentTarget.getBoundingClientRect();
      const ratio = Math.min(Math.max((event.clientX - rect.left) / rect.width, 0), 1);
      setPosition(ratio * duration);
    },
    [duration, setPosition]
  );

  return (
    <footer className="border-t border-slate-200 bg-white/80 px-6 py-3 backdrop-blur dark:border-slate-800 dark:bg-slate-900/80">
      <div className="grid grid-cols-[220px_1fr_220px] items-center gap-6">
        <div className="flex items-center space-x-3">
          <div className="h-14 w-14 rounded-md bg-slate-200 dark:bg-slate-800" />
          <div className="min-w-0">
            <p className="truncate text-sm font-semibold text-slate-800 dark:text-slate-100">
              {currentTrack?.title ?? 'Nenhuma faixa'}
            </p>
            <p className="truncate text-xs text-slate-500 dark:text-slate-400">
              {currentTrack?.artist ?? 'Adicione músicas para começar'}
            </p>
          </div>
        </div>
        <div className="flex flex-col items-center">
          <div className="flex items-center space-x-3">
            <button
              type="button"
              onClick={toggleShuffle}
              className={`rounded px-2 py-1 text-xs font-semibold uppercase tracking-wide ${
                shuffle ? 'text-sky-500' : 'text-slate-500'
              }`}
              aria-pressed={shuffle}
            >
              Shuffle
            </button>
            <button
              type="button"
              onClick={previous}
              className="rounded px-3 py-1 text-sm font-medium text-slate-600 hover:text-sky-600 focus:outline-none focus-visible:ring-2 focus-visible:ring-sky-400 dark:text-slate-200"
            >
              ◄◄
            </button>
            <button
              type="button"
              onClick={() => setIsPlaying(!isPlaying)}
              className="rounded-full bg-sky-500 px-5 py-2 text-sm font-semibold text-white shadow hover:bg-sky-600 focus:outline-none focus-visible:ring-2 focus-visible:ring-sky-400"
            >
              {isPlaying ? 'Pause' : 'Play'}
            </button>
            <button
              type="button"
              onClick={next}
              className="rounded px-3 py-1 text-sm font-medium text-slate-600 hover:text-sky-600 focus:outline-none focus-visible:ring-2 focus-visible:ring-sky-400 dark:text-slate-200"
            >
              ►►
            </button>
            <button
              type="button"
              onClick={cycleRepeat}
              className={`rounded px-2 py-1 text-xs font-semibold uppercase tracking-wide ${
                repeat !== 'none' ? 'text-sky-500' : 'text-slate-500'
              }`}
            >
              Repeat {repeat === 'track' ? '1' : repeat === 'all' ? '∞' : ''}
            </button>
          </div>
          <div className="mt-2 flex w-full items-center space-x-3 text-xs text-slate-500">
            <span>{formatTime(position)}</span>
            <div
              className="relative h-1.5 w-full cursor-pointer rounded-full bg-slate-200"
              onClick={handleSeek}
            >
              <div className="absolute inset-y-0 left-0 rounded-full bg-sky-500" style={{ width: `${progress}%` }} />
            </div>
            <span>{formatTime(duration)}</span>
          </div>
        </div>
        <div className="flex items-center justify-end space-x-3">
          <label className="text-xs font-semibold text-slate-500" htmlFor="volume">
            Volume
          </label>
          <input
            id="volume"
            type="range"
            min={0}
            max={1}
            step={0.01}
            value={volume}
            onChange={(event) => setVolume(Number(event.target.value))}
            className="h-1.5 w-40 cursor-pointer appearance-none rounded-full bg-slate-200 accent-sky-500"
          />
          <button
            type="button"
            onClick={onExpand}
            className="rounded-md border border-slate-300 px-3 py-1 text-xs font-semibold text-slate-500 transition hover:border-sky-500 hover:text-sky-600 focus:outline-none focus-visible:ring-2 focus-visible:ring-sky-400 dark:border-slate-700 dark:text-slate-300"
          >
            Expandir
          </button>
        </div>
      </div>
    </footer>
  );
};
