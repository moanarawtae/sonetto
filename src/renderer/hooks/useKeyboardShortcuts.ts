import { useEffect } from 'react';
import { PLAYBACK_SHORTCUTS } from '../../common/constants';
import { usePlayerStore } from '../state/playerStore';

const matchShortcut = (event: KeyboardEvent, shortcut: string) => {
  const parts = shortcut.split('+');
  const key = parts.pop();
  if (!key) {
    return false;
  }
  const ctrl = parts.includes('Ctrl');
  const cmd = parts.includes('Cmd');
  const alt = parts.includes('Alt');
  const shift = parts.includes('Shift');
  if (ctrl && !(event.ctrlKey || event.metaKey)) {
    return false;
  }
  if (cmd && !event.metaKey) {
    return false;
  }
  if (alt && !event.altKey) {
    return false;
  }
  if (shift && !event.shiftKey) {
    return false;
  }
  return event.code === key;
};

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
      if (matchShortcut(event, PLAYBACK_SHORTCUTS.PLAY_PAUSE)) {
        event.preventDefault();
        if (!currentTrack) {
          return;
        }
        setIsPlaying(!isPlaying);
      }
      if (matchShortcut(event, PLAYBACK_SHORTCUTS.NEXT_TRACK)) {
        event.preventDefault();
        next();
      }
      if (matchShortcut(event, PLAYBACK_SHORTCUTS.PREV_TRACK)) {
        event.preventDefault();
        previous();
      }
      if (matchShortcut(event, PLAYBACK_SHORTCUTS.SEEK_FORWARD)) {
        event.preventDefault();
        setPosition(Math.min(duration, position + 5));
      }
      if (matchShortcut(event, PLAYBACK_SHORTCUTS.SEEK_BACKWARD)) {
        event.preventDefault();
        setPosition(Math.max(0, position - 5));
      }
      if (matchShortcut(event, PLAYBACK_SHORTCUTS.VOLUME_UP)) {
        event.preventDefault();
        setVolume(Math.min(1, (Math.round((usePlayerStore.getState().volume + 0.05) * 100) / 100)));
      }
      if (matchShortcut(event, PLAYBACK_SHORTCUTS.VOLUME_DOWN)) {
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
