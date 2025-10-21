import { useEffect, useState } from 'react';
import type { LibrarySummary, ScanProgressPayload } from '../../common/types';
import { useLibraryStore } from '../state/libraryStore';
import { bridge } from '../bridge';

export const HomeView = () => {
  const [summary, setSummary] = useState<LibrarySummary>({ tracks: 0, artists: 0, albums: 0, playlists: 0 });
  const { scanning, scanProgress, setScanProgress } = useLibraryStore();

  useEffect(() => {
    void bridge.library.getSummary().then(setSummary);
    const unsubscribe = bridge.library.onScanProgress((payload: ScanProgressPayload) => {
      setScanProgress(payload);
    });
    return () => {
      unsubscribe();
    };
  }, [setScanProgress]);

  return (
    <div className="grid gap-6 lg:grid-cols-2 xl:grid-cols-4">
      <article className="rounded-lg border border-slate-200 bg-white/80 p-6 shadow-sm dark:border-slate-800 dark:bg-slate-900/60">
        <h3 className="text-xs uppercase text-slate-400">Faixas</h3>
        <p className="mt-2 text-3xl font-semibold text-slate-800 dark:text-slate-100">{summary.tracks}</p>
      </article>
      <article className="rounded-lg border border-slate-200 bg-white/80 p-6 shadow-sm dark:border-slate-800 dark:bg-slate-900/60">
        <h3 className="text-xs uppercase text-slate-400">Álbuns</h3>
        <p className="mt-2 text-3xl font-semibold text-slate-800 dark:text-slate-100">{summary.albums}</p>
      </article>
      <article className="rounded-lg border border-slate-200 bg-white/80 p-6 shadow-sm dark:border-slate-800 dark:bg-slate-900/60">
        <h3 className="text-xs uppercase text-slate-400">Artistas</h3>
        <p className="mt-2 text-3xl font-semibold text-slate-800 dark:text-slate-100">{summary.artists}</p>
      </article>
      <article className="rounded-lg border border-slate-200 bg-white/80 p-6 shadow-sm dark:border-slate-800 dark:bg-slate-900/60">
        <h3 className="text-xs uppercase text-slate-400">Playlists</h3>
        <p className="mt-2 text-3xl font-semibold text-slate-800 dark:text-slate-100">{summary.playlists}</p>
      </article>
      {scanning && scanProgress && (
        <article className="lg:col-span-2 xl:col-span-4 rounded-lg border border-sky-200 bg-sky-50/80 p-6 text-sky-700 dark:border-sky-700/50 dark:bg-sky-950/40 dark:text-sky-200">
          <h3 className="text-sm font-semibold">Escaneando biblioteca...</h3>
          <p className="text-xs">{scanProgress.currentPath}</p>
          <div className="mt-3 h-2 w-full rounded-full bg-sky-100 dark:bg-sky-900">
            <div
              className="h-2 rounded-full bg-sky-500"
              style={{ width: `${scanProgress.total ? (scanProgress.processed / scanProgress.total) * 100 : 0}%` }}
            />
          </div>
          <p className="mt-2 text-xs">
            {scanProgress.processed} de {scanProgress.total} arquivos
          </p>
        </article>
      )}
    </div>
  );
};
