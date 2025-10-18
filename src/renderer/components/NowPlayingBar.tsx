import { formatTime } from '@/utils/formatTime';
import { usePlayerStore } from '@/store/playerStore';
import type { ChangeEvent } from 'react';

const NowPlayingBar = () => {
  const {
    currentTrack,
    isPlaying,
    progress,
    duration,
    volume,
    isMuted,
    shuffle,
    repeatMode,
    togglePlay,
    setProgress,
    setVolume,
    toggleMute,
    toggleShuffle,
    cycleRepeatMode,
    next,
    previous
  } = usePlayerStore((state) => ({
    currentTrack: state.currentTrack,
    isPlaying: state.isPlaying,
    progress: state.progress,
    duration: state.duration,
    volume: state.volume,
    isMuted: state.isMuted,
    shuffle: state.shuffle,
    repeatMode: state.repeatMode,
    togglePlay: state.togglePlay,
    setProgress: state.setProgress,
    setVolume: state.setVolume,
    toggleMute: state.toggleMute,
    toggleShuffle: state.toggleShuffle,
    cycleRepeatMode: state.cycleRepeatMode,
    next: state.next,
    previous: state.previous
  }));

  const handleSeek = (event: ChangeEvent<HTMLInputElement>) => {
    setProgress(Number(event.target.value));
  };

  const handleVolumeChange = (event: ChangeEvent<HTMLInputElement>) => {
    setVolume(Number(event.target.value));
  };

  return (
    <footer className="grid grid-cols-[280px_minmax(300px,1fr)_220px] items-center gap-6 border-t border-slate-200 bg-white/80 px-4 py-3 text-sm backdrop-blur dark:border-slate-800 dark:bg-slate-900/80">
      <div className="flex items-center gap-3">
        <div className="flex h-14 w-14 items-center justify-center overflow-hidden rounded-md bg-slate-200 dark:bg-slate-800">
          {currentTrack?.coverUri ? (
            <img src={currentTrack.coverUri} alt="Capa do álbum" className="h-full w-full object-cover" />
          ) : (
            <span aria-hidden className="text-xl text-slate-500">
              ♪
            </span>
          )}
        </div>
        <div>
          <p className="font-medium text-slate-900 dark:text-slate-100">
            {currentTrack?.title ?? 'Nada tocando'}
          </p>
          <p className="text-xs text-slate-500 dark:text-slate-400">{currentTrack?.artist ?? 'Selecione uma faixa'}</p>
        </div>
      </div>
      <div className="flex flex-col items-center gap-2">
        <div className="flex items-center gap-4">
          <button
            type="button"
            className={`focus-ring rounded-full px-2 py-2 text-xl ${shuffle ? 'text-brand-500' : 'text-slate-500 dark:text-slate-400'}`}
            onClick={toggleShuffle}
            aria-pressed={shuffle}
          >
            🔀
          </button>
          <button
            type="button"
            className="focus-ring rounded-full px-2 py-2 text-xl text-slate-700 hover:text-brand-500 disabled:opacity-40 disabled:hover:text-slate-700 dark:text-slate-200"
            onClick={previous}
            aria-label="Faixa anterior"
            disabled={!currentTrack}
          >
            ⏮
          </button>
          <button
            type="button"
            className="focus-ring rounded-full bg-brand-500 px-4 py-2 text-xl text-white hover:bg-brand-400 disabled:cursor-not-allowed disabled:opacity-40"
            onClick={togglePlay}
            aria-label={isPlaying ? 'Pausar' : 'Reproduzir'}
            disabled={!currentTrack}
          >
            {isPlaying ? '⏸' : '▶️'}
          </button>
          <button
            type="button"
            className="focus-ring rounded-full px-2 py-2 text-xl text-slate-700 hover:text-brand-500 disabled:opacity-40 disabled:hover:text-slate-700 dark:text-slate-200"
            onClick={next}
            aria-label="Próxima faixa"
            disabled={!currentTrack}
          >
            ⏭
          </button>
          <button
            type="button"
            className={`focus-ring rounded-full px-2 py-2 text-xl ${repeatMode !== 'none' ? 'text-brand-500' : 'text-slate-500 dark:text-slate-400'}`}
            onClick={cycleRepeatMode}
            aria-label={`Modo repetição: ${repeatMode}`}
          >
            🔁
          </button>
        </div>
        <div className="flex w-full items-center gap-3 text-xs text-slate-500 dark:text-slate-400">
          <span className="tabular-nums">{formatTime(progress)}</span>
          <input
            type="range"
            min={0}
            max={duration || 0}
            value={Math.min(progress, duration || 0)}
            onChange={handleSeek}
            className="focus-ring h-1 w-full cursor-pointer rounded-full bg-slate-300 accent-brand-500 disabled:cursor-not-allowed disabled:opacity-50 dark:bg-slate-700"
            disabled={!currentTrack}
          />
          <span className="tabular-nums">{formatTime(duration)}</span>
        </div>
      </div>
      <div className="flex items-center justify-end gap-3 text-slate-500 dark:text-slate-300">
        <button
          type="button"
          className={`focus-ring rounded-full px-2 py-2 text-lg ${isMuted ? 'text-brand-500' : ''}`}
          onClick={toggleMute}
          aria-pressed={isMuted}
          aria-label={isMuted ? 'Reativar volume' : 'Silenciar'}
        >
          {isMuted ? '🔇' : '🔊'}
        </button>
        <input
          type="range"
          min={0}
          max={1}
          step={0.01}
          value={isMuted ? 0 : volume}
          onChange={handleVolumeChange}
          className="focus-ring h-1 w-28 cursor-pointer rounded-full bg-slate-300 accent-brand-500 dark:bg-slate-700"
          aria-label="Controle de volume"
        />
      </div>
    </footer>
  );
};

export default NowPlayingBar;
