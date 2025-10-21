import { NavLink } from 'react-router-dom';
import { useLibraryStore } from '../state/libraryStore';

const navItems = [
  { to: '/library', label: 'Início' },
  { to: '/library/tracks', label: 'Faixas' },
  { to: '/library/albums', label: 'Álbuns' },
  { to: '/library/artists', label: 'Artistas' },
  { to: '/library/playlists', label: 'Playlists' },
  { to: '/settings', label: 'Configurações' }
];

export const SidebarNav = () => {
  const setView = useLibraryStore((state) => state.setView);
  return (
    <nav className="w-64 shrink-0 border-r border-slate-200 bg-slate-50/80 p-4 dark:border-slate-800 dark:bg-slate-900/80">
      <div className="mb-6">
        <span className="text-2xl font-semibold tracking-tight text-slate-800 dark:text-slate-100">sonetto</span>
      </div>
      <ul className="space-y-2">
        {navItems.map((item) => (
          <li key={item.to}>
            <NavLink
              to={item.to}
              className={({ isActive }) =>
                `flex items-center rounded-md px-3 py-2 text-sm font-medium transition-colors focus:outline-none focus-visible:ring-2 focus-visible:ring-sky-500 ${
                  isActive
                    ? 'bg-sky-500/10 text-sky-600 dark:text-sky-300'
                    : 'text-slate-600 hover:bg-slate-200/70 dark:text-slate-300 dark:hover:bg-slate-800'
                }`
              }
              onClick={() => {
                if (item.to.includes('/tracks')) setView('tracks');
                if (item.to.includes('/albums')) setView('albums');
                if (item.to.includes('/artists')) setView('artists');
                if (item.to.includes('/playlists')) setView('playlists');
              }}
            >
              {item.label}
            </NavLink>
          </li>
        ))}
      </ul>
    </nav>
  );
};
