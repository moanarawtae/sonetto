import { FormEvent, useState } from 'react';
import { useSettingsStore } from '../state/settingsStore';

interface TopBarProps {
  onSearch: (term: string) => void;
  onAddFolder: () => Promise<void>;
}

export const TopBar = ({ onSearch, onAddFolder }: TopBarProps) => {
  const [term, setTerm] = useState('');
  const { theme, setTheme } = useSettingsStore();

  const handleSubmit = (event: FormEvent) => {
    event.preventDefault();
    onSearch(term);
  };

  return (
    <header className="flex items-center justify-between border-b border-slate-200 bg-white/70 px-6 py-4 backdrop-blur dark:border-slate-800 dark:bg-slate-900/70">
      <form onSubmit={handleSubmit} className="flex w-full max-w-xl items-center space-x-3">
        <label htmlFor="search" className="sr-only">
          Buscar na biblioteca
        </label>
        <input
          id="search"
          value={term}
          onChange={(event) => setTerm(event.target.value)}
          placeholder="Buscar por faixa, álbum ou artista"
          className="w-full rounded-md border border-slate-200 bg-white px-3 py-2 text-sm text-slate-700 outline-none transition focus:border-sky-500 focus:ring-2 focus:ring-sky-200 dark:border-slate-700 dark:bg-slate-800 dark:text-slate-100"
        />
        <button
          type="submit"
          className="rounded-md bg-sky-500 px-4 py-2 text-sm font-medium text-white shadow-sm transition hover:bg-sky-600 focus:outline-none focus-visible:ring-2 focus-visible:ring-sky-400"
        >
          Buscar
        </button>
      </form>
      <div className="flex items-center space-x-3">
        <button
          type="button"
          onClick={onAddFolder}
          className="rounded-md border border-slate-300 px-3 py-2 text-sm font-medium text-slate-600 transition hover:border-sky-500 hover:text-sky-600 focus:outline-none focus-visible:ring-2 focus-visible:ring-sky-400 dark:border-slate-700 dark:text-slate-200"
        >
          Adicionar pasta
        </button>
        <div className="flex items-center rounded-md border border-slate-300 p-1 dark:border-slate-700">
          {(['light', 'dark', 'system'] as const).map((value) => (
            <button
              key={value}
              type="button"
              onClick={() => void setTheme(value)}
              className={`rounded px-3 py-1 text-xs font-semibold capitalize transition focus:outline-none focus-visible:ring-2 focus-visible:ring-sky-400 ${
                theme === value
                  ? 'bg-sky-500 text-white'
                  : 'text-slate-600 hover:bg-slate-200 dark:text-slate-300 dark:hover:bg-slate-700'
              }`}
              aria-pressed={theme === value}
            >
              {value}
            </button>
          ))}
        </div>
      </div>
    </header>
  );
};
