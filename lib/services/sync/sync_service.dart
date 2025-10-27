import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../core/models/playlist.dart';
import '../../core/models/playlist_item.dart';
import '../../core/models/track.dart';
import '../../core/models/user_settings.dart';
import '../../data/remote/supabase_service.dart';
import '../../data/repositories/playlist_repository.dart';
import '../../data/repositories/settings_repository.dart';
import '../../data/repositories/track_repository.dart';

final syncReadyProvider = StateProvider<bool>((ref) => false);

class SyncService {
  SyncService(this._ref, this._supabase, this._tracks, this._playlists, this._settings);

  final Ref _ref;
  final SupabaseService _supabase;
  final TrackRepository _tracks;
  final PlaylistRepository _playlists;
  final SettingsRepository _settings;
  final Uuid _uuid = const Uuid();

  bool _isAuthenticated = false;
  DateTime? _lastSync;
  final List<RealtimeChannel> _channels = [];
  StreamSubscription<AuthStatus>? _authSub;

  bool get isAuthenticated => _isAuthenticated;

  Future<void> initialize() async {
    _isAuthenticated = _supabase.client.auth.currentSession != null;
    _authSub = _supabase.authState.listen(_handleAuthChange);
    if (_isAuthenticated) {
      await performFullSync();
    }
    _ref.read(syncReadyProvider.notifier).state = true;
  }

  Future<void> dispose() async {
    await _authSub?.cancel();
    await _clearRealtime();
  }

  Future<AuthStatus> signIn(String email, String password) async {
    final status = await _supabase.signInWithPassword(email: email, password: password);
    if (status == AuthStatus.signedIn) {
      await performFullSync();
    }
    return status;
  }

  Future<void> signOut() async {
    await _supabase.signOut();
    _isAuthenticated = false;
    _lastSync = null;
    await _clearRealtime();
    _ref.read(syncReadyProvider.notifier).state = true;
  }

  Future<void> performFullSync() async {
    if (_supabase.client.auth.currentUser == null) {
      return;
    }
    final since = _lastSync;
    final remoteTracks = await _tracks.fetchRemoteUpdated(since);
    await _tracks.saveLocalTracks(_resolveTrackConflicts(remoteTracks));

    final remotePlaylists = await _playlists.fetchRemotePlaylists(since);
    await _playlists.saveLocalPlaylists(remotePlaylists);

    final remoteItems = await _playlists.fetchRemotePlaylistItems(since);
    await _playlists.saveLocalPlaylistItems(remoteItems);

    final remoteSettings = await _settings.fetchRemote();
    if (remoteSettings != null) {
      await _settings.saveLocal(remoteSettings);
    }

    _lastSync = DateTime.now().toUtc();
    await _subscribeRealtime();
  }

  Future<void> upsertTrack(Track track) async {
    await _tracks.saveLocalTracks([track]);
    await _tracks.upsertRemote(track);
    _lastSync = DateTime.now().toUtc();
  }

  Future<void> deleteTrack(Track track) async {
    await _tracks.deleteLocal(track.id);
    await _tracks.deleteRemote(track.id);
    _lastSync = DateTime.now().toUtc();
  }

  Future<void> upsertPlaylist(Playlist playlist) async {
    await _playlists.saveLocalPlaylists([playlist]);
    await _playlists.upsertRemotePlaylist(playlist);
    _lastSync = DateTime.now().toUtc();
  }

  Future<Playlist> createPlaylist(String name) async {
    final userId = _supabase.client.auth.currentUser?.id;
    if (userId == null) {
      throw StateError('usuário não autenticado');
    }
    final now = DateTime.now().toUtc();
    final playlist = Playlist(
      id: _uuid.v4(),
      name: name,
      createdAt: now,
      updatedAt: now,
      userId: userId,
    );
    await upsertPlaylist(playlist);
    return playlist;
  }

  Future<void> renamePlaylist(Playlist playlist, String name) async {
    final updated = playlist.copyWith(name: name, updatedAt: DateTime.now().toUtc());
    await upsertPlaylist(updated);
  }

  Future<void> upsertPlaylistItem(PlaylistItem item) async {
    await _playlists.saveLocalPlaylistItems([item]);
    await _playlists.upsertRemoteItem(item);
    _lastSync = DateTime.now().toUtc();
  }

  Future<PlaylistItem> addTrackToPlaylist({
    required Playlist playlist,
    required Track track,
    int? position,
  }) async {
    final now = DateTime.now().toUtc();
    final item = PlaylistItem(
      id: _uuid.v4(),
      playlistId: playlist.id,
      trackId: track.id,
      position: position ?? now.millisecondsSinceEpoch,
      createdAt: now,
      updatedAt: now,
      userId: playlist.userId,
    );
    await upsertPlaylistItem(item);
    return item;
  }

  Future<void> deletePlaylist(String id) async {
    await _playlists.deleteLocalPlaylist(id);
    await _playlists.deleteRemotePlaylist(id);
    _lastSync = DateTime.now().toUtc();
  }

  Future<void> deletePlaylistItem(String id) async {
    await _playlists.deleteLocalItem(id);
    await _playlists.deleteRemoteItem(id);
    _lastSync = DateTime.now().toUtc();
  }

  Future<void> saveSettings(UserSettings settings) async {
    final updated = settings.copyWith(updatedAt: DateTime.now().toUtc());
    await _settings.saveLocal(updated);
    await _settings.upsertRemote(updated);
    _lastSync = DateTime.now().toUtc();
  }

  Future<UserSettings> loadOrCreateSettings() async {
    final local = await _settings.loadLocal();
    if (local != null) {
      return local;
    }
    final userId = _supabase.client.auth.currentUser?.id;
    if (userId == null) {
      throw StateError('usuário não autenticado');
    }
    final now = DateTime.now().toUtc();
    final defaults = UserSettings(
      id: _uuid.v4(),
      normalizeVolume: true,
      crossfadeMs: 5000,
      createdAt: now,
      updatedAt: now,
      userId: userId,
    );
    await saveSettings(defaults);
    return defaults;
  }

  Future<void> _subscribeRealtime() async {
    await _clearRealtime();

    final userId = _supabase.client.auth.currentUser?.id;
    if (userId == null) {
      return;
    }

    _channels.addAll([
      _supabase.subscribeTable('tracks', userId: userId, onChange: _handleTrackChange),
      _supabase.subscribeTable('playlists', userId: userId, onChange: _handlePlaylistChange),
      _supabase.subscribeTable('playlist_items', userId: userId, onChange: _handlePlaylistItemChange),
      _supabase.subscribeTable('settings', userId: userId, onChange: _handleSettingsChange),
    ]);
  }

  Future<void> _handleAuthChange(AuthStatus status) async {
    _isAuthenticated = status == AuthStatus.signedIn;
    if (_isAuthenticated) {
      await performFullSync();
    }
  }

  Future<void> _handleTrackChange(PostgresChangePayload payload) async {
    final record = _recordForEvent(payload);
    if (record == null) return;
    final track = Track.fromJson(Map<String, dynamic>.from(record));
    switch (payload.eventType) {
      case PostgresChangeEvent.insert:
      case PostgresChangeEvent.update:
        await _tracks.saveLocalTracks([track]);
        break;
      case PostgresChangeEvent.delete:
        await _tracks.deleteLocal(track.id);
        break;
      case PostgresChangeEvent.all:
        break;
    }
  }

  Future<void> _handlePlaylistChange(PostgresChangePayload payload) async {
    final record = _recordForEvent(payload);
    if (record == null) return;
    final playlist = Playlist.fromJson(Map<String, dynamic>.from(record));
    switch (payload.eventType) {
      case PostgresChangeEvent.insert:
      case PostgresChangeEvent.update:
        await _playlists.saveLocalPlaylists([playlist]);
        break;
      case PostgresChangeEvent.delete:
        await _playlists.deleteLocalPlaylist(playlist.id);
        break;
      case PostgresChangeEvent.all:
        break;
    }
  }

  Future<void> _handlePlaylistItemChange(PostgresChangePayload payload) async {
    final record = _recordForEvent(payload);
    if (record == null) return;
    final item = PlaylistItem.fromJson(Map<String, dynamic>.from(record));
    switch (payload.eventType) {
      case PostgresChangeEvent.insert:
      case PostgresChangeEvent.update:
        await _playlists.saveLocalPlaylistItems([item]);
        break;
      case PostgresChangeEvent.delete:
        await _playlists.deleteLocalItem(item.id);
        break;
      case PostgresChangeEvent.all:
        break;
    }
  }

  Future<void> _handleSettingsChange(PostgresChangePayload payload) async {
    final record = _recordForEvent(payload);
    if (record == null) return;
    final settings = UserSettings.fromJson(Map<String, dynamic>.from(record));
    switch (payload.eventType) {
      case PostgresChangeEvent.insert:
      case PostgresChangeEvent.update:
        await _settings.saveLocal(settings);
        break;
      case PostgresChangeEvent.delete:
        break;
      case PostgresChangeEvent.all:
        break;
    }
  }

  Iterable<Track> _resolveTrackConflicts(List<Track> remoteTracks) {
    return remoteTracks;
  }

  Future<void> _clearRealtime() async {
    for (final channel in _channels) {
      await channel.unsubscribe();
    }
    _channels.clear();
  }

  Map<String, dynamic>? _recordForEvent(PostgresChangePayload payload) {
    switch (payload.eventType) {
      case PostgresChangeEvent.delete:
        return payload.oldRecord.isEmpty ? null : payload.oldRecord;
      case PostgresChangeEvent.all:
        if (payload.newRecord.isNotEmpty) return payload.newRecord;
        return payload.oldRecord.isEmpty ? null : payload.oldRecord;
      case PostgresChangeEvent.insert:
      case PostgresChangeEvent.update:
        return payload.newRecord.isEmpty ? null : payload.newRecord;
    }
  }
}

final syncServiceProvider = Provider<SyncService>((ref) {
  final service = SyncService(
    ref,
    ref.watch(supabaseServiceProvider),
    ref.watch(trackRepositoryProvider),
    ref.watch(playlistRepositoryProvider),
    ref.watch(settingsRepositoryProvider),
  );
  ref.onDispose(service.dispose);
  return service;
});
