import { create } from 'zustand';
import { persist } from 'zustand/middleware';
import type { AudioFormat, TrackRecord } from '../../common/types';

type RepeatMode = 'none' | 'track' | 'all';

type QueueItem = {
  track: TrackRecord;
};

interface PlayerState {
  queue: QueueItem[];
  history: TrackRecord[];
  currentTrack: TrackRecord | null;
  isPlaying: boolean;
  repeat: RepeatMode;
  shuffle: boolean;
  volume: number;
  muted: boolean;
  position: number;
  duration: number;
  supportedFormats: AudioFormat[];
  unsupportedFormats: AudioFormat[];
  loadQueue: (tracks: TrackRecord[], startIndex: number) => void;
  enqueue: (track: TrackRecord, position: 'next' | 'end') => void;
  clearQueue: () => void;
  next: () => TrackRecord | null;
  previous: () => TrackRecord | null;
  setIsPlaying: (value: boolean) => void;
  setCurrentTrack: (track: TrackRecord | null) => void;
  setPosition: (position: number) => void;
  setDuration: (duration: number) => void;
  setVolume: (volume: number) => void;
  toggleMute: () => void;
  cycleRepeat: () => void;
  toggleShuffle: () => void;
  setFormatSupport: (payload: { supported: AudioFormat[]; unsupported: AudioFormat[] }) => void;
}

const cycleRepeatMode = (current: RepeatMode): RepeatMode => {
  switch (current) {
    case 'none':
      return 'all';
    case 'all':
      return 'track';
    case 'track':
      return 'none';
    default:
      return 'none';
  }
};

export const usePlayerStore = create<PlayerState>()(
  persist(
    (set, get) => ({
      queue: [],
      history: [],
      currentTrack: null,
      isPlaying: false,
      repeat: 'none',
      shuffle: false,
      volume: 0.8,
      muted: false,
      position: 0,
      duration: 0,
      supportedFormats: [],
      unsupportedFormats: [],
      loadQueue: (tracks, startIndex) => {
        const index = Math.max(0, Math.min(startIndex, tracks.length - 1));
        set({
          queue: tracks.map((track) => ({ track })),
          currentTrack: tracks[index] ?? null,
          history: [],
          position: 0,
          duration: 0,
          isPlaying: true
        });
      },
      enqueue: (track, position) => {
        const queue = get().queue.slice();
        if (position === 'next' && queue.length > 0) {
          queue.splice(1, 0, { track });
        } else {
          queue.push({ track });
        }
        set({ queue });
      },
      clearQueue: () => set({ queue: [], currentTrack: null, history: [], isPlaying: false, position: 0 }),
      next: () => {
        const state = get();
        if (state.repeat === 'track' && state.currentTrack) {
          set({ position: 0, isPlaying: true });
          return state.currentTrack;
        }
        const queue = state.queue.slice();
        if (!queue.length) {
          return null;
        }
        if (state.currentTrack) {
          set({ history: [...state.history, state.currentTrack] });
        }
        queue.shift();
        if (!queue.length) {
          if (state.repeat === 'all' && state.history.length) {
            const restartedQueue = [...state.history, state.currentTrack].filter(Boolean) as TrackRecord[];
            set({
              queue: restartedQueue.map((track) => ({ track })),
              history: [],
              currentTrack: restartedQueue[0] ?? null,
              position: 0
            });
            return restartedQueue[0] ?? null;
          }
          set({ queue: [], currentTrack: null, isPlaying: false, position: 0 });
          return null;
        }
        const current = queue[0]?.track ?? null;
        set({ queue, currentTrack: current, position: 0 });
        return current;
      },
      previous: () => {
        const state = get();
        const history = state.history.slice();
        if (!history.length) {
          return state.currentTrack;
        }
        const previousTrack = history.pop() ?? null;
        if (previousTrack) {
          set({ history, currentTrack: previousTrack, position: 0, isPlaying: true });
        }
        return previousTrack;
      },
      setIsPlaying: (value) => set({ isPlaying: value }),
      setCurrentTrack: (track) => set({ currentTrack: track }),
      setPosition: (position) => set({ position }),
      setDuration: (duration) => set({ duration }),
      setVolume: (volume) => set({ volume, muted: volume === 0 }),
      toggleMute: () => {
        const state = get();
        set({ muted: !state.muted, volume: !state.muted ? 0 : state.volume || 0.8 });
      },
      cycleRepeat: () => set((state) => ({ repeat: cycleRepeatMode(state.repeat) })),
      toggleShuffle: () => set((state) => ({ shuffle: !state.shuffle })),
      setFormatSupport: (payload) => set({
        supportedFormats: payload.supported,
        unsupportedFormats: payload.unsupported
      })
    }),
    {
      name: 'sonetto-player',
      partialize: (state) => ({
        volume: state.volume,
        repeat: state.repeat,
        shuffle: state.shuffle,
        supportedFormats: state.supportedFormats,
        unsupportedFormats: state.unsupportedFormats
      })
    }
  )
);
