export const IPC_CHANNELS = {
  LIBRARY_SCAN: 'library:scan',
  LIBRARY_SCAN_PROGRESS: 'library:scan-progress',
  LIBRARY_FETCH_TRACKS: 'library:fetch-tracks',
  LIBRARY_FETCH_ALBUMS: 'library:fetch-albums',
  LIBRARY_FETCH_ARTISTS: 'library:fetch-artists',
  LIBRARY_FETCH_PLAYLISTS: 'library:fetch-playlists',
  LIBRARY_GET_SUMMARY: 'library:get-summary',
  LIBRARY_GET_TRACK: 'library:get-track',
  LIBRARY_GET_COVER: 'library:get-cover',
  PLAYER_RESOLVE_TRACK: 'player:resolve-track',
  PLAYER_FORMAT_SUPPORT: 'player:format-support',
  SETTINGS_SELECT_FOLDERS: 'settings:select-folders',
  SETTINGS_GET: 'settings:get',
  SETTINGS_UPDATE: 'settings:update',
  APP_GET_VERSION: 'app:get-version',
  APP_OPEN_EXTERNAL: 'app:open-external'
} as const;

type ValueOf<T> = T[keyof T];
export type IpcChannel = ValueOf<typeof IPC_CHANNELS>;
