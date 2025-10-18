const navItems = [
  { label: 'Início', icon: '🏠' },
  { label: 'Biblioteca', icon: '🎵' },
  { label: 'Artistas', icon: '👤' },
  { label: 'Álbuns', icon: '💿' },
  { label: 'Playlists', icon: '📚' },
  { label: 'Pastas', icon: '🗂️' },
  { label: 'Configurações', icon: '⚙️' }
];

const SidebarNav = () => {
  return (
    <nav className="flex h-full flex-col gap-2 p-4 text-sm">
      <div className="text-2xl font-semibold tracking-tight text-brand-500">sonetto</div>
      <ul className="mt-6 flex flex-col gap-2 text-left font-medium text-slate-600 dark:text-slate-300">
        {navItems.map((item) => (
          <li key={item.label}>
            <button
              type="button"
              className="focus-ring flex w-full items-center gap-3 rounded-md px-3 py-2 text-left hover:bg-slate-200/80 dark:hover:bg-slate-800/80"
            >
              <span aria-hidden>{item.icon}</span>
              <span>{item.label}</span>
            </button>
          </li>
        ))}
      </ul>
    </nav>
  );
};

export default SidebarNav;
