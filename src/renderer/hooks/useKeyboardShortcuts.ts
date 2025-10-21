import { useEffect } from 'react';
import { PLAYBACK_SHORTCUTS } from '../../common/constants';
import { usePlayerStore } from '../state/playerStore';

const matchesSingleShortcut = (event: KeyboardEvent, shortcut: string) => {
  const parts = shortcut.split('+');
  const key = parts.pop();
  if (!key) {
    return false;
  }

  let requiresCtrl = false;
  let requiresMeta = false;
  let requiresAlt = false;
  let requiresShift = false;

  parts.forEach((part) => {
    const normalized = part.trim().toLowerCase();
    if (normalized === 'ctrl' || normalized === 'control') {
      requiresCtrl = true;
      return;
    }
    if (normalized === 'cmd' || normalized === 'command' || normalized === 'meta') {
      requiresMeta = true;
      return;
    }
    if (normalized === 'alt' || normalized === 'option') {
      requiresAlt = true;
      return;
    }
    if (normalized === 'shift') {
      requiresShift = true;
    }
  });

  if (requiresCtrl && !event.ctrlKey) {
    return false;
  }
  if (requiresMeta && !event.metaKey) {
    return false;
  }
  if (requiresAlt && !event.altKey) {
    return false;
  }
  if (requiresShift && !event.shiftKey) {
    return false;
  }

  return event.code === key;
};

const matchShortcut = (event: KeyboardEvent, shortcuts: readonly string[]) =>
  shortcuts.some((shortcut) => matchesSingleShortcut(event, shortcut));

export const useKeyboardShortcuts = () => {
  const {
    currentTrack,
    next,
    previous,
    setIsPlaying,
    isPlaying,
    setPosition,
    position,
    duration,
    setVolume
  } = usePlayerStore();

  useEffect(() => {
    const handler = (event: KeyboardEvent) => {
      if (event.target instanceof HTMLInputElement || event.target instanceof HTMLTextAreaElement) {
        return;
      }
      if (matchShortcut(event, PLAYBACK_SHORTCUTS.playPause)) {
        event.preventDefault();
        if (!currentTrack) {
          return;
        }
        setIsPlaying(!isPlaying);
      }
      if (matchShortcut(event, PLAYBACK_SHORTCUTS.next)) {
        event.preventDefault();
        next();
      }
      if (matchShortcut(event, PLAYBACK_SHORTCUTS.previous)) {
        event.preventDefault();
        previous();
      }
      if (matchShortcut(event, PLAYBACK_SHORTCUTS.seekForward)) {
        event.preventDefault();
        setPosition(Math.min(duration, position + 5));
      }
      if (matchShortcut(event, PLAYBACK_SHORTCUTS.seekBackward)) {
        event.preventDefault();
        setPosition(Math.max(0, position - 5));
      }
      if (matchShortcut(event, PLAYBACK_SHORTCUTS.volumeUp)) {
        event.preventDefault();
        setVolume(Math.min(1, (Math.round((usePlayerStore.getState().volume + 0.05) * 100) / 100)));
      }
      if (matchShortcut(event, PLAYBACK_SHORTCUTS.volumeDown)) {
        event.preventDefault();
        setVolume(Math.max(0, (Math.round((usePlayerStore.getState().volume - 0.05) * 100) / 100)));
      }
    };
    window.addEventListener('keydown', handler);
    return () => {
      window.removeEventListener('keydown', handler);
    };
  }, [currentTrack, duration, isPlaying, next, position, previous, setIsPlaying, setPosition, setVolume]);
};
