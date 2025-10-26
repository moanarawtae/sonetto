import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/models/playlist.dart';
import '../../core/models/playlist_item.dart';
import '../local/app_database.dart';
import '../remote/supabase_service.dart';

class PlaylistRepository {
  PlaylistRepository(this._db, this._supabase);

  final AppDatabase _db;
  final SupabaseService _supabase;

  Future<List<Playlist>> fetchRemotePlaylists(DateTime? since) async {
    final query = _supabase.client.from('playlists').select('*');
    if (since != null) {
      query.gte('updated_at', since.toIso8601String());
    }
    final data = await query;
    return (data as List<dynamic>)
        .map((json) => Playlist.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<List<PlaylistItem>> fetchRemotePlaylistItems(DateTime? since) async {
    final query = _supabase.client.from('playlist_items').select('*');
    if (since != null) {
      query.gte('updated_at', since.toIso8601String());
    }
    final data = await query;
    return (data as List<dynamic>)
        .map((json) => PlaylistItem.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<void> saveLocalPlaylists(Iterable<Playlist> playlists) async {
    if (playlists.isEmpty) return;
    await _db.replacePlaylists(playlists);
  }

  Future<List<Playlist>> getLocalPlaylists() => _db.getAllPlaylists();

  Future<Playlist?> getPlaylist(String id) => _db.getPlaylistById(id);

  Future<void> saveLocalPlaylistItems(Iterable<PlaylistItem> items) async {
    if (items.isEmpty) return;
    await _db.replacePlaylistItems(items);
  }

  Future<List<PlaylistItem>> getLocalItems(String playlistId) =>
      _db.getItemsForPlaylist(playlistId);

  Future<void> upsertRemotePlaylist(Playlist playlist) async {
    await _supabase.client.from('playlists').upsert(playlist.toJson());
  }

  Future<void> upsertRemoteItem(PlaylistItem item) async {
    await _supabase.client.from('playlist_items').upsert(item.toJson());
  }

  Future<void> deleteRemotePlaylist(String id) async {
    await _supabase.client.from('playlists').delete().eq('id', id);
  }

  Future<void> deleteRemoteItem(String id) async {
    await _supabase.client.from('playlist_items').delete().eq('id', id);
  }

  Future<void> deleteLocalPlaylist(String id) => _db.deletePlaylist(id);

  Future<void> deleteLocalItem(String id) => _db.deletePlaylistItem(id);

  Playlist? newestPlaylist(Iterable<Playlist> playlists) =>
      playlists.sortedBy<DateTime>((p) => p.updatedAt).lastOrNull;
}

final playlistRepositoryProvider = Provider<PlaylistRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  final supabase = ref.watch(supabaseServiceProvider);
  return PlaylistRepository(db, supabase);
});
