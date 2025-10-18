import { useEffect, useMemo, useRef } from 'react';
import { usePlayerStore } from '@/store/playerStore';

const AudioEngine = () => {
  const audioRef = useRef(new Audio());
  const {
    currentTrack,
    isPlaying,
    volume,
    isMuted,
    repeatMode,
    progress,
    queue,
    setIsPlaying,
    setDuration,
    setProgress,
    next
  } = usePlayerStore((state) => ({
    currentTrack: state.currentTrack,
    isPlaying: state.isPlaying,
    volume: state.volume,
    isMuted: state.isMuted,
    repeatMode: state.repeatMode,
    progress: state.progress,
    queue: state.queue,
    setIsPlaying: state.setIsPlaying,
    setDuration: state.setDuration,
    setProgress: state.setProgress,
    next: state.next
  }));

  const audio = audioRef.current;

  const source = useMemo(() => {
    if (!currentTrack) return undefined;
    if (currentTrack.path.startsWith('file://')) {
      return currentTrack.path;
    }
    return `file://${currentTrack.path}`;
  }, [currentTrack]);

  useEffect(() => {
    audio.volume = isMuted ? 0 : volume;
  }, [audio, volume, isMuted]);

  useEffect(() => {
    if (!source) return;
    if (audio.src !== source) {
      audio.src = source;
    }
    if (isPlaying) {
      void audio.play().catch(() => {
        setIsPlaying(false);
      });
    }
  }, [audio, source, isPlaying, setIsPlaying]);

  useEffect(() => {
    if (!currentTrack) {
      audio.pause();
      audio.removeAttribute('src');
      setIsPlaying(false);
      return;
    }
    if (isPlaying) {
      void audio.play().catch(() => {
        setIsPlaying(false);
      });
    } else {
      audio.pause();
    }
  }, [audio, currentTrack, isPlaying, setIsPlaying]);

  useEffect(() => {
    if (!Number.isFinite(progress) || Number.isNaN(progress)) return;
    if (Math.abs(audio.currentTime - progress) > 0.2) {
      audio.currentTime = progress;
    }
  }, [audio, progress]);

  useEffect(() => {
    const handleLoaded = () => {
      setDuration(audio.duration || currentTrack?.duration || 0);
    };
    const handleTimeUpdate = () => {
      setProgress(audio.currentTime);
    };
    const handleEnded = () => {
      if (repeatMode === 'track') {
        audio.currentTime = 0;
        void audio.play();
        return;
      }
      if (queue.length === 0) {
        setIsPlaying(false);
        return;
      }
      next();
    };

    audio.addEventListener('loadedmetadata', handleLoaded);
    audio.addEventListener('timeupdate', handleTimeUpdate);
    audio.addEventListener('ended', handleEnded);

    return () => {
      audio.removeEventListener('loadedmetadata', handleLoaded);
      audio.removeEventListener('timeupdate', handleTimeUpdate);
      audio.removeEventListener('ended', handleEnded);
    };
  }, [audio, queue.length, next, repeatMode, setDuration, setIsPlaying, setProgress, currentTrack]);

  return null;
};

export default AudioEngine;
