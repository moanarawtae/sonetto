import { FormEvent, useState } from 'react';
import { useTheme } from '@/hooks/useTheme';

interface TopBarProps {
  onSearch: (term: string) => void;
  onAddFolder: () => void;
}

const TopBar = ({ onSearch, onAddFolder }: TopBarProps) => {
  const [value, setValue] = useState('');
  const { theme, toggleTheme } = useTheme();

  const handleSubmit = (event: FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    onSearch(value);
  };

  return (
    <header className="flex items-center justify-between gap-4 border-b border-slate-200 bg-white/70 px-6 py-3 backdrop-blur dark:border-slate-800 dark:bg-slate-900/70">
      <form className="flex flex-1 items-center" onSubmit={handleSubmit} role="search">
        <label htmlFor="search" className="sr-only">
          Buscar na biblioteca
        </label>
        <input
          id="search"
          name="search"
          value={value}
          onChange={(event) => setValue(event.target.value)}
          placeholder="Buscar por faixa, artista ou álbum"
          className="focus-ring w-full rounded-full border border-transparent bg-slate-100 px-4 py-2 text-sm text-slate-800 shadow-inner placeholder:text-slate-500 dark:bg-slate-800 dark:text-slate-100"
        />
      </form>
      <div className="flex items-center gap-2">
        <button
          type="button"
          className="focus-ring rounded-full bg-brand-500 px-3 py-2 text-sm font-medium text-white shadow hover:bg-brand-400"
          onClick={onAddFolder}
        >
          Adicionar pasta
        </button>
        <button
          type="button"
          className="focus-ring rounded-full border border-slate-200 px-3 py-2 text-sm font-medium text-slate-700 hover:bg-slate-100 dark:border-slate-700 dark:text-slate-200 dark:hover:bg-slate-800"
          onClick={toggleTheme}
          aria-label={`Alternar para modo ${theme === 'light' ? 'escuro' : 'claro'}`}
        >
          {theme === 'light' ? '🌙' : '☀️'}
        </button>
      </div>
    </header>
  );
};

export default TopBar;
