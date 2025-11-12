create extension if not exists "pgcrypto";

create table if not exists public.tracks (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  title text not null,
  artist text not null,
  album text not null,
  duration_ms int4 not null,
  source_url text not null,
  artwork_url text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.playlists (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  name text not null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.playlist_items (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  playlist_id uuid not null references public.playlists(id) on delete cascade,
  track_id uuid not null references public.tracks(id) on delete cascade,
  position int4 not null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.settings (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  normalize_volume boolean not null default true,
  crossfade_ms int4 not null default 5000,
  scrobble_to_lastfm boolean not null default false,
  lastfm_session_key text,
  lastfm_username text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create or replace function public.set_updated_at()
returns trigger language plpgsql as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

create trigger set_updated_at_tracks
before update on public.tracks
for each row execute function public.set_updated_at();

create trigger set_updated_at_playlists
before update on public.playlists
for each row execute function public.set_updated_at();

create trigger set_updated_at_items
before update on public.playlist_items
for each row execute function public.set_updated_at();

create trigger set_updated_at_settings
before update on public.settings
for each row execute function public.set_updated_at();

alter table public.tracks enable row level security;
alter table public.playlists enable row level security;
alter table public.playlist_items enable row level security;
alter table public.settings enable row level security;

create policy tracks_select on public.tracks
for select using (user_id = auth.uid());
create policy tracks_insert on public.tracks
for insert with check (user_id = auth.uid());
create policy tracks_update on public.tracks
for update using (user_id = auth.uid());
create policy tracks_delete on public.tracks
for delete using (user_id = auth.uid());

create policy playlists_select on public.playlists
for select using (user_id = auth.uid());
create policy playlists_insert on public.playlists
for insert with check (user_id = auth.uid());
create policy playlists_update on public.playlists
for update using (user_id = auth.uid());
create policy playlists_delete on public.playlists
for delete using (user_id = auth.uid());

create policy playlist_items_select on public.playlist_items
for select using (user_id = auth.uid());
create policy playlist_items_insert on public.playlist_items
for insert with check (user_id = auth.uid());
create policy playlist_items_update on public.playlist_items
for update using (user_id = auth.uid());
create policy playlist_items_delete on public.playlist_items
for delete using (user_id = auth.uid());

create policy settings_select on public.settings
for select using (user_id = auth.uid());
create policy settings_insert on public.settings
for insert with check (user_id = auth.uid());
create policy settings_update on public.settings
for update using (user_id = auth.uid());
create policy settings_delete on public.settings
for delete using (user_id = auth.uid());
