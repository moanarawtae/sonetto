import { useState } from 'react';
import SidebarNav from '@/components/SidebarNav';
import TopBar from '@/components/TopBar';
import NowPlayingBar from '@/components/NowPlayingBar';
import AudioEngine from '@/components/AudioEngine';
import { usePlayerStore } from '@/store/playerStore';
import type { SonettoTrack } from '../types/global';

const App = () => {
  const [searchTerm, setSearchTerm] = useState('');
  const setTrack = usePlayerStore((state) => state.setTrack);

  const handleAddFolder = async () => {
    const file = await window.sonetto.selectAudioFile();
    if (!file) return;
    const track: SonettoTrack = {
      id: file,
      path: file,
      title: file.split(/[\\/]/).pop() ?? 'Faixa desconhecida',
      artist: 'Artista desconhecido',
      duration: 0
    };
    setTrack(track, { autoplay: true });
  };

  return (
    <div className="flex h-screen w-screen flex-col bg-white text-slate-900 dark:bg-slate-950 dark:text-slate-100">
      <AudioEngine />
      <div className="flex flex-1 overflow-hidden">
        <aside className="hidden w-64 border-r border-slate-200 bg-white/70 backdrop-blur lg:block dark:border-slate-800 dark:bg-slate-900/70">
          <SidebarNav />
        </aside>
        <main className="flex flex-1 flex-col overflow-hidden">
          <TopBar onSearch={setSearchTerm} onAddFolder={handleAddFolder} />
          <section className="flex-1 overflow-auto bg-slate-50 p-6 dark:bg-slate-950/60">
            <div className="mx-auto flex max-w-5xl flex-col gap-6">
              <header>
                <h1 className="text-2xl font-semibold tracking-tight">Descubra sua biblioteca</h1>
                <p className="text-sm text-slate-600 dark:text-slate-400">
                  Adicione pastas para começar a construir sua biblioteca local. O Sonetto indexará metadados, capas e permitirá criar playlists inteligentes.
                </p>
              </header>
              <div className="rounded-2xl border border-dashed border-slate-300 bg-white/80 p-8 text-center text-slate-500 shadow-sm dark:border-slate-700 dark:bg-slate-900/70">
                <p className="text-base font-medium">Busca atual: {searchTerm || '—'}</p>
                <p className="mt-2 text-sm">
                  Esta é uma prévia da interface. As seções de biblioteca, playlists e fila dinâmica serão habilitadas conforme evoluímos os próximos marcos.
                </p>
              </div>
            </div>
          </section>
        </main>
      </div>
      <NowPlayingBar />
    </div>
  );
};

export default App;
