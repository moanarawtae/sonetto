import { create } from 'zustand';
import { persist } from 'zustand/middleware';
import type { SonettoTrack } from '../../types/global';

type RepeatMode = 'none' | 'track' | 'all';

interface PlayerState {
  currentTrack?: SonettoTrack;
  queue: SonettoTrack[];
  history: SonettoTrack[];
  isPlaying: boolean;
  progress: number;
  duration: number;
  volume: number;
  isMuted: boolean;
  shuffle: boolean;
  repeatMode: RepeatMode;
  setTrack: (track: SonettoTrack, options?: { autoplay?: boolean }) => void;
  setQueue: (tracks: SonettoTrack[]) => void;
  togglePlay: () => void;
  setIsPlaying: (value: boolean) => void;
  setProgress: (value: number) => void;
  setDuration: (value: number) => void;
  next: () => void;
  previous: () => void;
  setVolume: (value: number) => void;
  toggleMute: () => void;
  toggleShuffle: () => void;
  cycleRepeatMode: () => void;
}

const repeatOrder: RepeatMode[] = ['none', 'all', 'track'];

export const usePlayerStore = create<PlayerState>()(
  persist(
    (set, get) => ({
      currentTrack: undefined,
      queue: [],
      history: [],
      isPlaying: false,
      progress: 0,
      duration: 0,
      volume: 0.8,
      isMuted: false,
      shuffle: false,
      repeatMode: 'none',
      setTrack: (track, options) => {
        set((state) => ({
          currentTrack: track,
          isPlaying: options?.autoplay ?? state.isPlaying,
          progress: 0,
          duration: track.duration ?? state.duration
        }));
      },
      setQueue: (tracks) => set({ queue: tracks }),
      togglePlay: () => set((state) => ({ isPlaying: !state.isPlaying })),
      setIsPlaying: (value) => set({ isPlaying: value }),
      setProgress: (value) =>
        set((state) => ({
          progress: Math.min(Math.max(value, 0), state.duration || value)
        })),
      setDuration: (value) => set({ duration: value }),
      next: () => {
        const state = get();
        if (!state.queue.length) {
          if (state.repeatMode === 'track' && state.currentTrack) {
            set({ progress: 0 });
            return;
          }
          return;
        }
        const [nextTrack, ...rest] = state.queue;
        set({
          currentTrack: nextTrack,
          history: state.currentTrack ? [state.currentTrack, ...state.history] : state.history,
          queue: rest,
          progress: 0,
          isPlaying: true
        });
      },
      previous: () => {
        const state = get();
        if (state.history.length === 0) return;
        const [last, ...remaining] = state.history;
        set({
          currentTrack: last,
          history: remaining,
          queue: state.currentTrack ? [state.currentTrack, ...state.queue] : state.queue,
          progress: 0,
          isPlaying: true
        });
      },
      setVolume: (value) => set({ volume: Math.min(1, Math.max(0, value)), isMuted: false }),
      toggleMute: () => set((state) => ({ isMuted: !state.isMuted })),
      toggleShuffle: () => set((state) => ({ shuffle: !state.shuffle })),
      cycleRepeatMode: () =>
        set((state) => {
          const currentIndex = repeatOrder.indexOf(state.repeatMode);
          const nextMode = repeatOrder[(currentIndex + 1) % repeatOrder.length];
          return { repeatMode: nextMode };
        })
    }),
    {
      name: 'sonetto-player'
    }
  )
);
