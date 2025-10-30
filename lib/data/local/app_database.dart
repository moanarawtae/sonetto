import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../core/models/playlist.dart';
import '../../core/models/playlist_item.dart';
import '../../core/models/track.dart';
import '../../core/models/user_settings.dart';

part 'app_database.g.dart';

@DataClassName('TrackRow')
class Tracks extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get artist => text()();
  TextColumn get album => text()();
  IntColumn get durationMs => integer()();
  TextColumn get sourceUrl => text()();
  TextColumn get artworkUrl => text().nullable()();
  TextColumn get localPath => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get userId => text()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('PlaylistRow')
class Playlists extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get userId => text()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('PlaylistItemRow')
class PlaylistItems extends Table {
  TextColumn get id => text()();
  TextColumn get playlistId => text()();
  TextColumn get trackId => text()();
  IntColumn get position => integer()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get userId => text()();

  @override
  Set<Column> get primaryKey => {id};
}

class SettingsEntries extends Table {
  TextColumn get id => text()();
  BoolColumn get normalizeVolume => boolean().withDefault(const Constant(true))();
  IntColumn get crossfadeMs => integer().withDefault(const Constant(5000))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get userId => text()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [Tracks, Playlists, PlaylistItems, SettingsEntries])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onUpgrade: (migrator, from, to) async {
          if (from < 2) {
            await migrator.addColumn(tracks, tracks.localPath);
          }
        },
      );

  Future<void> replaceTrack(Track track) async {
    await into(tracks).insertOnConflictUpdate(_trackToCompanion(track));
  }

  Future<void> replaceTracks(Iterable<Track> all) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(
        tracks,
        all.map(_trackToCompanion),
      );
    });
  }

  Future<void> deleteTrack(String id) => (delete(tracks)..where((t) => t.id.equals(id))).go();

  Future<List<Track>> searchTracks(String query) async {
    final rows = await (select(tracks)
          ..where((tbl) => tbl.title.like('%$query%') | tbl.artist.like('%$query%'))
          ..orderBy([(tbl) => OrderingTerm.asc(tbl.title)]))
        .get();
    return rows.map(_trackFromRow).toList();
  }

  Future<List<Track>> getAllTracks() async {
    final rows = await (select(tracks)..orderBy([(tbl) => OrderingTerm.asc(tbl.title)])).get();
    return rows.map(_trackFromRow).toList();
  }

  Future<Track?> getTrackById(String id) async {
    final row = await (select(tracks)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
    return row == null ? null : _trackFromRow(row);
  }

  Stream<List<Track>> watchTracks(String query) {
    final selection = select(tracks)
      ..orderBy([(tbl) => OrderingTerm.asc(tbl.title)]);
    if (query.isNotEmpty) {
      final pattern = '%$query%';
      selection.where((tbl) => tbl.title.like(pattern) | tbl.artist.like(pattern));
    }
    return selection.watch().map((rows) => rows.map(_trackFromRow).toList());
  }

  Future<void> replacePlaylist(Playlist playlist) async {
    await into(playlists).insertOnConflictUpdate(_playlistToCompanion(playlist));
  }

  Future<void> replacePlaylists(Iterable<Playlist> all) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(playlists, all.map(_playlistToCompanion));
    });
  }

  Future<void> deletePlaylist(String id) => (delete(playlists)..where((tbl) => tbl.id.equals(id))).go();

  Future<List<Playlist>> getAllPlaylists() async {
    final rows = await select(playlists).get();
    return rows.map(_playlistFromRow).toList();
  }

  Future<Playlist?> getPlaylistById(String id) async {
    final row = await (select(playlists)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
    return row == null ? null : _playlistFromRow(row);
  }

  Future<void> replacePlaylistItems(Iterable<PlaylistItem> items) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(
        playlistItems,
        items.map(_playlistItemToCompanion),
      );
    });
  }

  Future<void> deletePlaylistItem(String id) => (delete(playlistItems)..where((tbl) => tbl.id.equals(id))).go();

  Future<List<PlaylistItem>> getItemsForPlaylist(String playlistId) async {
    final rows = await (select(playlistItems)
          ..where((tbl) => tbl.playlistId.equals(playlistId))
          ..orderBy([(tbl) => OrderingTerm.asc(tbl.position)])).
        get();
    return rows.map(_playlistItemFromRow).toList();
  }

  Future<void> saveSettings(UserSettings settings) async {
    await into(settingsEntries).insertOnConflictUpdate(_settingsToCompanion(settings));
  }

  Future<UserSettings?> loadSettings() async {
    final row = await select(settingsEntries).getSingleOrNull();
    return row == null ? null : _settingsFromRow(row);
  }

  TracksCompanion _trackToCompanion(Track track) => TracksCompanion(
        id: Value(track.id),
        title: Value(track.title),
        artist: Value(track.artist),
        album: Value(track.album),
        durationMs: Value(track.durationMs),
        sourceUrl: Value(track.sourceUrl),
        artworkUrl: Value(track.artworkUrl),
        localPath: Value(track.localPath),
        createdAt: Value(track.createdAt),
        updatedAt: Value(track.updatedAt),
        userId: Value(track.userId),
      );

  Track _trackFromRow(TrackRow row) => Track(
        id: row.id,
        title: row.title,
        artist: row.artist,
        album: row.album,
        durationMs: row.durationMs,
        sourceUrl: row.sourceUrl,
        artworkUrl: row.artworkUrl,
        localPath: row.localPath,
        createdAt: row.createdAt,
        updatedAt: row.updatedAt,
        userId: row.userId,
      );

  PlaylistsCompanion _playlistToCompanion(Playlist playlist) => PlaylistsCompanion(
        id: Value(playlist.id),
        name: Value(playlist.name),
        createdAt: Value(playlist.createdAt),
        updatedAt: Value(playlist.updatedAt),
        userId: Value(playlist.userId),
      );

  Playlist _playlistFromRow(PlaylistRow row) => Playlist(
        id: row.id,
        name: row.name,
        createdAt: row.createdAt,
        updatedAt: row.updatedAt,
        userId: row.userId,
      );

  PlaylistItemsCompanion _playlistItemToCompanion(PlaylistItem item) => PlaylistItemsCompanion(
        id: Value(item.id),
        playlistId: Value(item.playlistId),
        trackId: Value(item.trackId),
        position: Value(item.position),
        createdAt: Value(item.createdAt),
        updatedAt: Value(item.updatedAt),
        userId: Value(item.userId),
      );

  PlaylistItem _playlistItemFromRow(PlaylistItemRow row) => PlaylistItem(
        id: row.id,
        playlistId: row.playlistId,
        trackId: row.trackId,
        position: row.position,
        createdAt: row.createdAt,
        updatedAt: row.updatedAt,
        userId: row.userId,
      );

  SettingsEntriesCompanion _settingsToCompanion(UserSettings settings) => SettingsEntriesCompanion(
        id: Value(settings.id),
        normalizeVolume: Value(settings.normalizeVolume),
        crossfadeMs: Value(settings.crossfadeMs),
        createdAt: Value(settings.createdAt),
        updatedAt: Value(settings.updatedAt),
        userId: Value(settings.userId),
      );

  UserSettings _settingsFromRow(SettingsEntry row) => UserSettings(
        id: row.id,
        normalizeVolume: row.normalizeVolume,
        crossfadeMs: row.crossfadeMs,
        createdAt: row.createdAt,
        updatedAt: row.updatedAt,
        userId: row.userId,
      );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    if (kIsWeb) {
      throw UnsupportedError('web não suportado');
    }
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'sonetto.db'));
    return NativeDatabase.createInBackground(file);
  });
}

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});
