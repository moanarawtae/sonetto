import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/models/track.dart';
import '../local/app_database.dart';
import '../remote/supabase_service.dart';

class TrackRepository {
  TrackRepository(this._db, this._supabase);

  final AppDatabase _db;
  final SupabaseService _supabase;

  Future<List<Track>> fetchRemoteUpdated(DateTime? since) async {
    final query = _supabase.client.from('tracks').select('*');
    if (since != null) {
      query.gte('updated_at', since.toIso8601String());
    }
    final data = await query;
    return (data as List<dynamic>)
        .map((json) => Track.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<void> saveLocalTracks(Iterable<Track> tracks) async {
    if (tracks.isEmpty) return;
    await _db.replaceTracks(tracks);
  }

  Future<List<Track>> getLocalTracks() => _db.getAllTracks();

  Future<Track?> getTrack(String id) => _db.getTrackById(id);

  Future<void> upsertRemote(Track track) async {
    await _supabase.client.from('tracks').upsert(track.toJson());
  }

  Future<void> deleteRemote(String id) async {
    await _supabase.client.from('tracks').delete().eq('id', id);
  }

  Future<void> deleteLocal(String id) => _db.deleteTrack(id);

  Future<List<Track>> searchLocal(String query) async {
    if (query.isEmpty) {
      return _db.getAllTracks();
    }
    return _db.searchTracks(query);
  }

  Track? newest(Iterable<Track> tracks) => tracks.sortedBy<DateTime>((t) => t.updatedAt).lastOrNull;
}

final trackRepositoryProvider = Provider<TrackRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  final supabase = ref.watch(supabaseServiceProvider);
  return TrackRepository(db, supabase);
});
