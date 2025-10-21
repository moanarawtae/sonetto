import { useEffect, useRef } from 'react';
import { usePlayerStore } from '../state/playerStore';
import { bridge } from '../bridge';

export const AudioEngine = () => {
  const audioRef = useRef<HTMLAudioElement | null>(null);
  const {
    currentTrack,
    isPlaying,
    setIsPlaying,
    next,
    setPosition,
    setDuration,
    position,
    volume,
    setFormatSupport
  } = usePlayerStore();

  useEffect(() => {
    const bootstrap = async () => {
      const support = await bridge.player.ensureFormats();
      setFormatSupport(support);
    };
    void bootstrap();
  }, [setFormatSupport]);

  useEffect(() => {
    if (!currentTrack || !audioRef.current) {
      return;
    }
    const audio = audioRef.current;
    const loadTrack = async () => {
      const path = await bridge.player.resolveTrackPath(currentTrack.id);
      audio.src = path;
      audio.currentTime = 0;
      await audio.play().catch(() => {
        setIsPlaying(false);
      });
    };
    void loadTrack();
  }, [currentTrack, setIsPlaying]);

  useEffect(() => {
    const audio = audioRef.current;
    if (!audio) {
      return;
    }
    if (isPlaying) {
      void audio.play().catch(() => setIsPlaying(false));
    } else {
      audio.pause();
    }
  }, [isPlaying, setIsPlaying]);

  useEffect(() => {
    const audio = audioRef.current;
    if (!audio) {
      return;
    }
    audio.volume = volume;
  }, [volume]);

  useEffect(() => {
    const audio = audioRef.current;
    if (!audio) {
      return;
    }
    const handleTimeUpdate = () => {
      setPosition(audio.currentTime);
    };
    const handleLoaded = () => {
      setDuration(audio.duration);
    };
    const handleEnded = () => {
      const upcoming = next();
      if (!upcoming) {
        setIsPlaying(false);
      }
    };
    audio.addEventListener('timeupdate', handleTimeUpdate);
    audio.addEventListener('loadedmetadata', handleLoaded);
    audio.addEventListener('ended', handleEnded);
    return () => {
      audio.removeEventListener('timeupdate', handleTimeUpdate);
      audio.removeEventListener('loadedmetadata', handleLoaded);
      audio.removeEventListener('ended', handleEnded);
    };
  }, [next, setDuration, setIsPlaying, setPosition]);

  useEffect(() => {
    if (!audioRef.current) {
      return;
    }
    if (Math.abs(audioRef.current.currentTime - position) > 1) {
      audioRef.current.currentTime = position;
    }
  }, [position]);

  return <audio ref={audioRef} hidden data-testid="audio-engine" />;
};
