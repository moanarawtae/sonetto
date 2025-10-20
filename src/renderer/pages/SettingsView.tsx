import { useEffect } from 'react';
import { useSettingsStore } from '../state/settingsStore';
import { useLibraryStore } from '../state/libraryStore';

export const SettingsView = () => {
  const { monitoredFolders, hideUnsupported, update, load } = useSettingsStore();
  const { setScanning } = useLibraryStore();

  useEffect(() => {
    void load();
  }, [load]);

  const handleFolderSelect = async () => {
    const folders = await window.sonetto.settings.selectFolders();
    if (folders.length) {
      await update({ monitoredFolders: [...new Set([...monitoredFolders, ...folders])] });
    }
  };

  const handleScan = async () => {
    if (!monitoredFolders.length) {
      return;
    }
    setScanning(true);
    await window.sonetto.library.scan(monitoredFolders);
    setScanning(false);
  };

  return (
    <div className="space-y-6">
      <section className="rounded-lg border border-slate-200 bg-white/80 p-6 dark:border-slate-800 dark:bg-slate-900/60">
        <header className="mb-4">
          <h2 className="text-lg font-semibold text-slate-800 dark:text-slate-100">Biblioteca</h2>
          <p className="text-sm text-slate-500 dark:text-slate-400">
            Gerencie as pastas monitoradas e controle revarreduras da biblioteca.
          </p>
        </header>
        <div className="space-y-4">
          <div>
            <h3 className="text-sm font-semibold text-slate-700 dark:text-slate-200">Pastas monitoradas</h3>
            <ul className="mt-2 space-y-1 text-sm text-slate-600 dark:text-slate-300">
              {monitoredFolders.map((folder) => (
                <li key={folder} className="truncate">{folder}</li>
              ))}
              {!monitoredFolders.length && <li className="text-slate-400">Nenhuma pasta adicionada ainda.</li>}
            </ul>
            <button
              type="button"
              onClick={handleFolderSelect}
              className="mt-3 rounded-md bg-sky-500 px-3 py-1.5 text-sm font-semibold text-white transition hover:bg-sky-600 focus:outline-none focus-visible:ring-2 focus-visible:ring-sky-400"
            >
              Selecionar pastas
            </button>
          </div>
          <div className="flex items-center justify-between">
            <div>
              <h3 className="text-sm font-semibold text-slate-700 dark:text-slate-200">Ocultar formatos não suportados</h3>
              <p className="text-xs text-slate-500 dark:text-slate-400">
                Caso seu sistema não suporte algum formato, ele será omitido das listagens.
              </p>
            </div>
            <label className="inline-flex items-center space-x-2">
              <input
                type="checkbox"
                checked={hideUnsupported}
                onChange={(event) => void update({ hideUnsupported: event.target.checked })}
                className="h-4 w-4 rounded border-slate-300 text-sky-500 focus:ring-sky-400"
              />
              <span className="text-sm text-slate-600 dark:text-slate-300">Ativar</span>
            </label>
          </div>
          <button
            type="button"
            onClick={handleScan}
            className="rounded-md border border-slate-300 px-3 py-2 text-sm font-medium text-slate-600 transition hover:border-sky-500 hover:text-sky-600 focus:outline-none focus-visible:ring-2 focus-visible:ring-sky-400 dark:border-slate-700 dark:text-slate-200"
          >
            Reescanear agora
          </button>
        </div>
      </section>
    </div>
  );
};
