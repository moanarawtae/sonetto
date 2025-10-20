import { FixedSizeList as List, ListChildComponentProps } from 'react-window';
import AutoSizer from 'react-virtualized-auto-sizer';
import { usePlayerStore } from '../state/playerStore';
import type { TrackRecord } from '../../common/types';
import { formatTime } from '../utils/formatTime';

interface TrackTableProps {
  tracks: TrackRecord[];
}

const Row = ({ index, style, data }: ListChildComponentProps<TrackRecord[]>) => {
  const track = data[index];
  const { loadQueue } = usePlayerStore();
  return (
    <div
      style={style}
      className="grid grid-cols-[40px_1.5fr_1fr_120px_80px] items-center gap-4 border-b border-slate-100 px-4 text-sm text-slate-600 hover:bg-slate-100/60 dark:border-slate-800 dark:text-slate-300 dark:hover:bg-slate-800"
      role="button"
      tabIndex={0}
      onClick={() => loadQueue(data, index)}
      onKeyDown={(event) => {
        if (event.key === 'Enter' || event.key === ' ') {
          event.preventDefault();
          loadQueue(data, index);
        }
      }}
    >
      <span className="text-xs text-slate-400">{index + 1}</span>
      <div className="min-w-0">
        <p className="truncate font-medium text-slate-800 dark:text-slate-100">{track.title}</p>
        <p className="truncate text-xs text-slate-500 dark:text-slate-400">{track.artist ?? 'Artista desconhecido'}</p>
      </div>
      <span className="truncate text-xs text-slate-500 dark:text-slate-400">{track.album ?? 'Álbum desconhecido'}</span>
      <span className="text-xs text-slate-500 dark:text-slate-400">{formatTime(track.duration ?? 0)}</span>
      <span className="text-xs uppercase text-slate-400">{track.format}</span>
    </div>
  );
};

export const TrackTable = ({ tracks }: TrackTableProps) => {
  return (
    <div className="h-full">
      <AutoSizer>
        {({ height, width }) => (
          <List height={height} width={width} itemCount={tracks.length} itemSize={72} itemData={tracks}>
            {Row}
          </List>
        )}
      </AutoSizer>
    </div>
  );
};
