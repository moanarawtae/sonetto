// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $TracksTable extends Tracks with TableInfo<$TracksTable, TrackRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TracksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _artistMeta = const VerificationMeta('artist');
  @override
  late final GeneratedColumn<String> artist = GeneratedColumn<String>(
      'artist', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _albumMeta = const VerificationMeta('album');
  @override
  late final GeneratedColumn<String> album = GeneratedColumn<String>(
      'album', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _durationMsMeta =
      const VerificationMeta('durationMs');
  @override
  late final GeneratedColumn<int> durationMs = GeneratedColumn<int>(
      'duration_ms', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _sourceUrlMeta =
      const VerificationMeta('sourceUrl');
  @override
  late final GeneratedColumn<String> sourceUrl = GeneratedColumn<String>(
      'source_url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _artworkUrlMeta =
      const VerificationMeta('artworkUrl');
  @override
  late final GeneratedColumn<String> artworkUrl = GeneratedColumn<String>(
      'artwork_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _localPathMeta =
      const VerificationMeta('localPath');
  @override
  late final GeneratedColumn<String> localPath = GeneratedColumn<String>(
      'local_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        artist,
        album,
        durationMs,
        sourceUrl,
        artworkUrl,
        localPath,
        createdAt,
        updatedAt,
        userId
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tracks';
  @override
  VerificationContext validateIntegrity(Insertable<TrackRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('artist')) {
      context.handle(_artistMeta,
          artist.isAcceptableOrUnknown(data['artist']!, _artistMeta));
    } else if (isInserting) {
      context.missing(_artistMeta);
    }
    if (data.containsKey('album')) {
      context.handle(
          _albumMeta, album.isAcceptableOrUnknown(data['album']!, _albumMeta));
    } else if (isInserting) {
      context.missing(_albumMeta);
    }
    if (data.containsKey('duration_ms')) {
      context.handle(
          _durationMsMeta,
          durationMs.isAcceptableOrUnknown(
              data['duration_ms']!, _durationMsMeta));
    } else if (isInserting) {
      context.missing(_durationMsMeta);
    }
    if (data.containsKey('source_url')) {
      context.handle(_sourceUrlMeta,
          sourceUrl.isAcceptableOrUnknown(data['source_url']!, _sourceUrlMeta));
    } else if (isInserting) {
      context.missing(_sourceUrlMeta);
    }
    if (data.containsKey('artwork_url')) {
      context.handle(
          _artworkUrlMeta,
          artworkUrl.isAcceptableOrUnknown(
              data['artwork_url']!, _artworkUrlMeta));
    }
    if (data.containsKey('local_path')) {
      context.handle(_localPathMeta,
          localPath.isAcceptableOrUnknown(data['local_path']!, _localPathMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TrackRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TrackRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      artist: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}artist'])!,
      album: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}album'])!,
      durationMs: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration_ms'])!,
      sourceUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source_url'])!,
      artworkUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}artwork_url']),
      localPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}local_path']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
    );
  }

  @override
  $TracksTable createAlias(String alias) {
    return $TracksTable(attachedDatabase, alias);
  }
}

class TrackRow extends DataClass implements Insertable<TrackRow> {
  final String id;
  final String title;
  final String artist;
  final String album;
  final int durationMs;
  final String sourceUrl;
  final String? artworkUrl;
  final String? localPath;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String userId;
  const TrackRow(
      {required this.id,
      required this.title,
      required this.artist,
      required this.album,
      required this.durationMs,
      required this.sourceUrl,
      this.artworkUrl,
      this.localPath,
      required this.createdAt,
      required this.updatedAt,
      required this.userId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['artist'] = Variable<String>(artist);
    map['album'] = Variable<String>(album);
    map['duration_ms'] = Variable<int>(durationMs);
    map['source_url'] = Variable<String>(sourceUrl);
    if (!nullToAbsent || artworkUrl != null) {
      map['artwork_url'] = Variable<String>(artworkUrl);
    }
    if (!nullToAbsent || localPath != null) {
      map['local_path'] = Variable<String>(localPath);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['user_id'] = Variable<String>(userId);
    return map;
  }

  TracksCompanion toCompanion(bool nullToAbsent) {
    return TracksCompanion(
      id: Value(id),
      title: Value(title),
      artist: Value(artist),
      album: Value(album),
      durationMs: Value(durationMs),
      sourceUrl: Value(sourceUrl),
      artworkUrl: artworkUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(artworkUrl),
      localPath: localPath == null && nullToAbsent
          ? const Value.absent()
          : Value(localPath),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      userId: Value(userId),
    );
  }

  factory TrackRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TrackRow(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      artist: serializer.fromJson<String>(json['artist']),
      album: serializer.fromJson<String>(json['album']),
      durationMs: serializer.fromJson<int>(json['durationMs']),
      sourceUrl: serializer.fromJson<String>(json['sourceUrl']),
      artworkUrl: serializer.fromJson<String?>(json['artworkUrl']),
      localPath: serializer.fromJson<String?>(json['localPath']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      userId: serializer.fromJson<String>(json['userId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'artist': serializer.toJson<String>(artist),
      'album': serializer.toJson<String>(album),
      'durationMs': serializer.toJson<int>(durationMs),
      'sourceUrl': serializer.toJson<String>(sourceUrl),
      'artworkUrl': serializer.toJson<String?>(artworkUrl),
      'localPath': serializer.toJson<String?>(localPath),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'userId': serializer.toJson<String>(userId),
    };
  }

  TrackRow copyWith(
          {String? id,
          String? title,
          String? artist,
          String? album,
          int? durationMs,
          String? sourceUrl,
          Value<String?> artworkUrl = const Value.absent(),
          Value<String?> localPath = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt,
          String? userId}) =>
      TrackRow(
        id: id ?? this.id,
        title: title ?? this.title,
        artist: artist ?? this.artist,
        album: album ?? this.album,
        durationMs: durationMs ?? this.durationMs,
        sourceUrl: sourceUrl ?? this.sourceUrl,
        artworkUrl: artworkUrl.present ? artworkUrl.value : this.artworkUrl,
        localPath: localPath.present ? localPath.value : this.localPath,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        userId: userId ?? this.userId,
      );
  TrackRow copyWithCompanion(TracksCompanion data) {
    return TrackRow(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      artist: data.artist.present ? data.artist.value : this.artist,
      album: data.album.present ? data.album.value : this.album,
      durationMs:
          data.durationMs.present ? data.durationMs.value : this.durationMs,
      sourceUrl: data.sourceUrl.present ? data.sourceUrl.value : this.sourceUrl,
      artworkUrl:
          data.artworkUrl.present ? data.artworkUrl.value : this.artworkUrl,
      localPath: data.localPath.present ? data.localPath.value : this.localPath,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      userId: data.userId.present ? data.userId.value : this.userId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TrackRow(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('artist: $artist, ')
          ..write('album: $album, ')
          ..write('durationMs: $durationMs, ')
          ..write('sourceUrl: $sourceUrl, ')
          ..write('artworkUrl: $artworkUrl, ')
          ..write('localPath: $localPath, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('userId: $userId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, artist, album, durationMs,
      sourceUrl, artworkUrl, localPath, createdAt, updatedAt, userId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TrackRow &&
          other.id == this.id &&
          other.title == this.title &&
          other.artist == this.artist &&
          other.album == this.album &&
          other.durationMs == this.durationMs &&
          other.sourceUrl == this.sourceUrl &&
          other.artworkUrl == this.artworkUrl &&
          other.localPath == this.localPath &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.userId == this.userId);
}

class TracksCompanion extends UpdateCompanion<TrackRow> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> artist;
  final Value<String> album;
  final Value<int> durationMs;
  final Value<String> sourceUrl;
  final Value<String?> artworkUrl;
  final Value<String?> localPath;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> userId;
  final Value<int> rowid;
  const TracksCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.artist = const Value.absent(),
    this.album = const Value.absent(),
    this.durationMs = const Value.absent(),
    this.sourceUrl = const Value.absent(),
    this.artworkUrl = const Value.absent(),
    this.localPath = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.userId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TracksCompanion.insert({
    required String id,
    required String title,
    required String artist,
    required String album,
    required int durationMs,
    required String sourceUrl,
    this.artworkUrl = const Value.absent(),
    this.localPath = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    required String userId,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        artist = Value(artist),
        album = Value(album),
        durationMs = Value(durationMs),
        sourceUrl = Value(sourceUrl),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt),
        userId = Value(userId);
  static Insertable<TrackRow> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? artist,
    Expression<String>? album,
    Expression<int>? durationMs,
    Expression<String>? sourceUrl,
    Expression<String>? artworkUrl,
    Expression<String>? localPath,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? userId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (artist != null) 'artist': artist,
      if (album != null) 'album': album,
      if (durationMs != null) 'duration_ms': durationMs,
      if (sourceUrl != null) 'source_url': sourceUrl,
      if (artworkUrl != null) 'artwork_url': artworkUrl,
      if (localPath != null) 'local_path': localPath,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (userId != null) 'user_id': userId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TracksCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String>? artist,
      Value<String>? album,
      Value<int>? durationMs,
      Value<String>? sourceUrl,
      Value<String?>? artworkUrl,
      Value<String?>? localPath,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<String>? userId,
      Value<int>? rowid}) {
    return TracksCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      album: album ?? this.album,
      durationMs: durationMs ?? this.durationMs,
      sourceUrl: sourceUrl ?? this.sourceUrl,
      artworkUrl: artworkUrl ?? this.artworkUrl,
      localPath: localPath ?? this.localPath,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      userId: userId ?? this.userId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (artist.present) {
      map['artist'] = Variable<String>(artist.value);
    }
    if (album.present) {
      map['album'] = Variable<String>(album.value);
    }
    if (durationMs.present) {
      map['duration_ms'] = Variable<int>(durationMs.value);
    }
    if (sourceUrl.present) {
      map['source_url'] = Variable<String>(sourceUrl.value);
    }
    if (artworkUrl.present) {
      map['artwork_url'] = Variable<String>(artworkUrl.value);
    }
    if (localPath.present) {
      map['local_path'] = Variable<String>(localPath.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TracksCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('artist: $artist, ')
          ..write('album: $album, ')
          ..write('durationMs: $durationMs, ')
          ..write('sourceUrl: $sourceUrl, ')
          ..write('artworkUrl: $artworkUrl, ')
          ..write('localPath: $localPath, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('userId: $userId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PlaylistsTable extends Playlists
    with TableInfo<$PlaylistsTable, PlaylistRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlaylistsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, createdAt, updatedAt, userId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'playlists';
  @override
  VerificationContext validateIntegrity(Insertable<PlaylistRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlaylistRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlaylistRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
    );
  }

  @override
  $PlaylistsTable createAlias(String alias) {
    return $PlaylistsTable(attachedDatabase, alias);
  }
}

class PlaylistRow extends DataClass implements Insertable<PlaylistRow> {
  final String id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String userId;
  const PlaylistRow(
      {required this.id,
      required this.name,
      required this.createdAt,
      required this.updatedAt,
      required this.userId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['user_id'] = Variable<String>(userId);
    return map;
  }

  PlaylistsCompanion toCompanion(bool nullToAbsent) {
    return PlaylistsCompanion(
      id: Value(id),
      name: Value(name),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      userId: Value(userId),
    );
  }

  factory PlaylistRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlaylistRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      userId: serializer.fromJson<String>(json['userId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'userId': serializer.toJson<String>(userId),
    };
  }

  PlaylistRow copyWith(
          {String? id,
          String? name,
          DateTime? createdAt,
          DateTime? updatedAt,
          String? userId}) =>
      PlaylistRow(
        id: id ?? this.id,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        userId: userId ?? this.userId,
      );
  PlaylistRow copyWithCompanion(PlaylistsCompanion data) {
    return PlaylistRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      userId: data.userId.present ? data.userId.value : this.userId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlaylistRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('userId: $userId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, createdAt, updatedAt, userId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlaylistRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.userId == this.userId);
}

class PlaylistsCompanion extends UpdateCompanion<PlaylistRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> userId;
  final Value<int> rowid;
  const PlaylistsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.userId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlaylistsCompanion.insert({
    required String id,
    required String name,
    required DateTime createdAt,
    required DateTime updatedAt,
    required String userId,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt),
        userId = Value(userId);
  static Insertable<PlaylistRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? userId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (userId != null) 'user_id': userId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PlaylistsCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<String>? userId,
      Value<int>? rowid}) {
    return PlaylistsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      userId: userId ?? this.userId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlaylistsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('userId: $userId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PlaylistItemsTable extends PlaylistItems
    with TableInfo<$PlaylistItemsTable, PlaylistItemRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlaylistItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _playlistIdMeta =
      const VerificationMeta('playlistId');
  @override
  late final GeneratedColumn<String> playlistId = GeneratedColumn<String>(
      'playlist_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _trackIdMeta =
      const VerificationMeta('trackId');
  @override
  late final GeneratedColumn<String> trackId = GeneratedColumn<String>(
      'track_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _positionMeta =
      const VerificationMeta('position');
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
      'position', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, playlistId, trackId, position, createdAt, updatedAt, userId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'playlist_items';
  @override
  VerificationContext validateIntegrity(Insertable<PlaylistItemRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('playlist_id')) {
      context.handle(
          _playlistIdMeta,
          playlistId.isAcceptableOrUnknown(
              data['playlist_id']!, _playlistIdMeta));
    } else if (isInserting) {
      context.missing(_playlistIdMeta);
    }
    if (data.containsKey('track_id')) {
      context.handle(_trackIdMeta,
          trackId.isAcceptableOrUnknown(data['track_id']!, _trackIdMeta));
    } else if (isInserting) {
      context.missing(_trackIdMeta);
    }
    if (data.containsKey('position')) {
      context.handle(_positionMeta,
          position.isAcceptableOrUnknown(data['position']!, _positionMeta));
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlaylistItemRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlaylistItemRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      playlistId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}playlist_id'])!,
      trackId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}track_id'])!,
      position: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}position'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
    );
  }

  @override
  $PlaylistItemsTable createAlias(String alias) {
    return $PlaylistItemsTable(attachedDatabase, alias);
  }
}

class PlaylistItemRow extends DataClass implements Insertable<PlaylistItemRow> {
  final String id;
  final String playlistId;
  final String trackId;
  final int position;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String userId;
  const PlaylistItemRow(
      {required this.id,
      required this.playlistId,
      required this.trackId,
      required this.position,
      required this.createdAt,
      required this.updatedAt,
      required this.userId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['playlist_id'] = Variable<String>(playlistId);
    map['track_id'] = Variable<String>(trackId);
    map['position'] = Variable<int>(position);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['user_id'] = Variable<String>(userId);
    return map;
  }

  PlaylistItemsCompanion toCompanion(bool nullToAbsent) {
    return PlaylistItemsCompanion(
      id: Value(id),
      playlistId: Value(playlistId),
      trackId: Value(trackId),
      position: Value(position),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      userId: Value(userId),
    );
  }

  factory PlaylistItemRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlaylistItemRow(
      id: serializer.fromJson<String>(json['id']),
      playlistId: serializer.fromJson<String>(json['playlistId']),
      trackId: serializer.fromJson<String>(json['trackId']),
      position: serializer.fromJson<int>(json['position']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      userId: serializer.fromJson<String>(json['userId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'playlistId': serializer.toJson<String>(playlistId),
      'trackId': serializer.toJson<String>(trackId),
      'position': serializer.toJson<int>(position),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'userId': serializer.toJson<String>(userId),
    };
  }

  PlaylistItemRow copyWith(
          {String? id,
          String? playlistId,
          String? trackId,
          int? position,
          DateTime? createdAt,
          DateTime? updatedAt,
          String? userId}) =>
      PlaylistItemRow(
        id: id ?? this.id,
        playlistId: playlistId ?? this.playlistId,
        trackId: trackId ?? this.trackId,
        position: position ?? this.position,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        userId: userId ?? this.userId,
      );
  PlaylistItemRow copyWithCompanion(PlaylistItemsCompanion data) {
    return PlaylistItemRow(
      id: data.id.present ? data.id.value : this.id,
      playlistId:
          data.playlistId.present ? data.playlistId.value : this.playlistId,
      trackId: data.trackId.present ? data.trackId.value : this.trackId,
      position: data.position.present ? data.position.value : this.position,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      userId: data.userId.present ? data.userId.value : this.userId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlaylistItemRow(')
          ..write('id: $id, ')
          ..write('playlistId: $playlistId, ')
          ..write('trackId: $trackId, ')
          ..write('position: $position, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('userId: $userId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, playlistId, trackId, position, createdAt, updatedAt, userId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlaylistItemRow &&
          other.id == this.id &&
          other.playlistId == this.playlistId &&
          other.trackId == this.trackId &&
          other.position == this.position &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.userId == this.userId);
}

class PlaylistItemsCompanion extends UpdateCompanion<PlaylistItemRow> {
  final Value<String> id;
  final Value<String> playlistId;
  final Value<String> trackId;
  final Value<int> position;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> userId;
  final Value<int> rowid;
  const PlaylistItemsCompanion({
    this.id = const Value.absent(),
    this.playlistId = const Value.absent(),
    this.trackId = const Value.absent(),
    this.position = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.userId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlaylistItemsCompanion.insert({
    required String id,
    required String playlistId,
    required String trackId,
    required int position,
    required DateTime createdAt,
    required DateTime updatedAt,
    required String userId,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        playlistId = Value(playlistId),
        trackId = Value(trackId),
        position = Value(position),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt),
        userId = Value(userId);
  static Insertable<PlaylistItemRow> custom({
    Expression<String>? id,
    Expression<String>? playlistId,
    Expression<String>? trackId,
    Expression<int>? position,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? userId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (playlistId != null) 'playlist_id': playlistId,
      if (trackId != null) 'track_id': trackId,
      if (position != null) 'position': position,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (userId != null) 'user_id': userId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PlaylistItemsCompanion copyWith(
      {Value<String>? id,
      Value<String>? playlistId,
      Value<String>? trackId,
      Value<int>? position,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<String>? userId,
      Value<int>? rowid}) {
    return PlaylistItemsCompanion(
      id: id ?? this.id,
      playlistId: playlistId ?? this.playlistId,
      trackId: trackId ?? this.trackId,
      position: position ?? this.position,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      userId: userId ?? this.userId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (playlistId.present) {
      map['playlist_id'] = Variable<String>(playlistId.value);
    }
    if (trackId.present) {
      map['track_id'] = Variable<String>(trackId.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlaylistItemsCompanion(')
          ..write('id: $id, ')
          ..write('playlistId: $playlistId, ')
          ..write('trackId: $trackId, ')
          ..write('position: $position, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('userId: $userId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SettingsEntriesTable extends SettingsEntries
    with TableInfo<$SettingsEntriesTable, SettingsEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _normalizeVolumeMeta =
      const VerificationMeta('normalizeVolume');
  @override
  late final GeneratedColumn<bool> normalizeVolume = GeneratedColumn<bool>(
      'normalize_volume', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("normalize_volume" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _crossfadeMsMeta =
      const VerificationMeta('crossfadeMs');
  @override
  late final GeneratedColumn<int> crossfadeMs = GeneratedColumn<int>(
      'crossfade_ms', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(5000));
  static const VerificationMeta _scrobbleToLastFmMeta =
      const VerificationMeta('scrobbleToLastFm');
  @override
  late final GeneratedColumn<bool> scrobbleToLastFm = GeneratedColumn<bool>(
      'scrobble_to_last_fm', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("scrobble_to_last_fm" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _lastFmSessionKeyMeta =
      const VerificationMeta('lastFmSessionKey');
  @override
  late final GeneratedColumn<String> lastFmSessionKey = GeneratedColumn<String>(
      'last_fm_session_key', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _lastFmUsernameMeta =
      const VerificationMeta('lastFmUsername');
  @override
  late final GeneratedColumn<String> lastFmUsername = GeneratedColumn<String>(
      'last_fm_username', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        normalizeVolume,
        crossfadeMs,
        scrobbleToLastFm,
        lastFmSessionKey,
        lastFmUsername,
        createdAt,
        updatedAt,
        userId
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'settings_entries';
  @override
  VerificationContext validateIntegrity(Insertable<SettingsEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('normalize_volume')) {
      context.handle(
          _normalizeVolumeMeta,
          normalizeVolume.isAcceptableOrUnknown(
              data['normalize_volume']!, _normalizeVolumeMeta));
    }
    if (data.containsKey('crossfade_ms')) {
      context.handle(
          _crossfadeMsMeta,
          crossfadeMs.isAcceptableOrUnknown(
              data['crossfade_ms']!, _crossfadeMsMeta));
    }
    if (data.containsKey('scrobble_to_last_fm')) {
      context.handle(
          _scrobbleToLastFmMeta,
          scrobbleToLastFm.isAcceptableOrUnknown(
              data['scrobble_to_last_fm']!, _scrobbleToLastFmMeta));
    }
    if (data.containsKey('last_fm_session_key')) {
      context.handle(
          _lastFmSessionKeyMeta,
          lastFmSessionKey.isAcceptableOrUnknown(
              data['last_fm_session_key']!, _lastFmSessionKeyMeta));
    }
    if (data.containsKey('last_fm_username')) {
      context.handle(
          _lastFmUsernameMeta,
          lastFmUsername.isAcceptableOrUnknown(
              data['last_fm_username']!, _lastFmUsernameMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SettingsEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SettingsEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      normalizeVolume: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}normalize_volume'])!,
      crossfadeMs: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}crossfade_ms'])!,
      scrobbleToLastFm: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}scrobble_to_last_fm'])!,
      lastFmSessionKey: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}last_fm_session_key']),
      lastFmUsername: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}last_fm_username']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
    );
  }

  @override
  $SettingsEntriesTable createAlias(String alias) {
    return $SettingsEntriesTable(attachedDatabase, alias);
  }
}

class SettingsEntry extends DataClass implements Insertable<SettingsEntry> {
  final String id;
  final bool normalizeVolume;
  final int crossfadeMs;
  final bool scrobbleToLastFm;
  final String? lastFmSessionKey;
  final String? lastFmUsername;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String userId;
  const SettingsEntry(
      {required this.id,
      required this.normalizeVolume,
      required this.crossfadeMs,
      required this.scrobbleToLastFm,
      this.lastFmSessionKey,
      this.lastFmUsername,
      required this.createdAt,
      required this.updatedAt,
      required this.userId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['normalize_volume'] = Variable<bool>(normalizeVolume);
    map['crossfade_ms'] = Variable<int>(crossfadeMs);
    map['scrobble_to_last_fm'] = Variable<bool>(scrobbleToLastFm);
    if (!nullToAbsent || lastFmSessionKey != null) {
      map['last_fm_session_key'] = Variable<String>(lastFmSessionKey);
    }
    if (!nullToAbsent || lastFmUsername != null) {
      map['last_fm_username'] = Variable<String>(lastFmUsername);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['user_id'] = Variable<String>(userId);
    return map;
  }

  SettingsEntriesCompanion toCompanion(bool nullToAbsent) {
    return SettingsEntriesCompanion(
      id: Value(id),
      normalizeVolume: Value(normalizeVolume),
      crossfadeMs: Value(crossfadeMs),
      scrobbleToLastFm: Value(scrobbleToLastFm),
      lastFmSessionKey: lastFmSessionKey == null && nullToAbsent
          ? const Value.absent()
          : Value(lastFmSessionKey),
      lastFmUsername: lastFmUsername == null && nullToAbsent
          ? const Value.absent()
          : Value(lastFmUsername),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      userId: Value(userId),
    );
  }

  factory SettingsEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SettingsEntry(
      id: serializer.fromJson<String>(json['id']),
      normalizeVolume: serializer.fromJson<bool>(json['normalizeVolume']),
      crossfadeMs: serializer.fromJson<int>(json['crossfadeMs']),
      scrobbleToLastFm: serializer.fromJson<bool>(json['scrobbleToLastFm']),
      lastFmSessionKey: serializer.fromJson<String?>(json['lastFmSessionKey']),
      lastFmUsername: serializer.fromJson<String?>(json['lastFmUsername']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      userId: serializer.fromJson<String>(json['userId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'normalizeVolume': serializer.toJson<bool>(normalizeVolume),
      'crossfadeMs': serializer.toJson<int>(crossfadeMs),
      'scrobbleToLastFm': serializer.toJson<bool>(scrobbleToLastFm),
      'lastFmSessionKey': serializer.toJson<String?>(lastFmSessionKey),
      'lastFmUsername': serializer.toJson<String?>(lastFmUsername),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'userId': serializer.toJson<String>(userId),
    };
  }

  SettingsEntry copyWith(
          {String? id,
          bool? normalizeVolume,
          int? crossfadeMs,
          bool? scrobbleToLastFm,
          Value<String?> lastFmSessionKey = const Value.absent(),
          Value<String?> lastFmUsername = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt,
          String? userId}) =>
      SettingsEntry(
        id: id ?? this.id,
        normalizeVolume: normalizeVolume ?? this.normalizeVolume,
        crossfadeMs: crossfadeMs ?? this.crossfadeMs,
        scrobbleToLastFm: scrobbleToLastFm ?? this.scrobbleToLastFm,
        lastFmSessionKey: lastFmSessionKey.present
            ? lastFmSessionKey.value
            : this.lastFmSessionKey,
        lastFmUsername:
            lastFmUsername.present ? lastFmUsername.value : this.lastFmUsername,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        userId: userId ?? this.userId,
      );
  SettingsEntry copyWithCompanion(SettingsEntriesCompanion data) {
    return SettingsEntry(
      id: data.id.present ? data.id.value : this.id,
      normalizeVolume: data.normalizeVolume.present
          ? data.normalizeVolume.value
          : this.normalizeVolume,
      crossfadeMs:
          data.crossfadeMs.present ? data.crossfadeMs.value : this.crossfadeMs,
      scrobbleToLastFm: data.scrobbleToLastFm.present
          ? data.scrobbleToLastFm.value
          : this.scrobbleToLastFm,
      lastFmSessionKey: data.lastFmSessionKey.present
          ? data.lastFmSessionKey.value
          : this.lastFmSessionKey,
      lastFmUsername: data.lastFmUsername.present
          ? data.lastFmUsername.value
          : this.lastFmUsername,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      userId: data.userId.present ? data.userId.value : this.userId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SettingsEntry(')
          ..write('id: $id, ')
          ..write('normalizeVolume: $normalizeVolume, ')
          ..write('crossfadeMs: $crossfadeMs, ')
          ..write('scrobbleToLastFm: $scrobbleToLastFm, ')
          ..write('lastFmSessionKey: $lastFmSessionKey, ')
          ..write('lastFmUsername: $lastFmUsername, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('userId: $userId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      normalizeVolume,
      crossfadeMs,
      scrobbleToLastFm,
      lastFmSessionKey,
      lastFmUsername,
      createdAt,
      updatedAt,
      userId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SettingsEntry &&
          other.id == this.id &&
          other.normalizeVolume == this.normalizeVolume &&
          other.crossfadeMs == this.crossfadeMs &&
          other.scrobbleToLastFm == this.scrobbleToLastFm &&
          other.lastFmSessionKey == this.lastFmSessionKey &&
          other.lastFmUsername == this.lastFmUsername &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.userId == this.userId);
}

class SettingsEntriesCompanion extends UpdateCompanion<SettingsEntry> {
  final Value<String> id;
  final Value<bool> normalizeVolume;
  final Value<int> crossfadeMs;
  final Value<bool> scrobbleToLastFm;
  final Value<String?> lastFmSessionKey;
  final Value<String?> lastFmUsername;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> userId;
  final Value<int> rowid;
  const SettingsEntriesCompanion({
    this.id = const Value.absent(),
    this.normalizeVolume = const Value.absent(),
    this.crossfadeMs = const Value.absent(),
    this.scrobbleToLastFm = const Value.absent(),
    this.lastFmSessionKey = const Value.absent(),
    this.lastFmUsername = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.userId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SettingsEntriesCompanion.insert({
    required String id,
    this.normalizeVolume = const Value.absent(),
    this.crossfadeMs = const Value.absent(),
    this.scrobbleToLastFm = const Value.absent(),
    this.lastFmSessionKey = const Value.absent(),
    this.lastFmUsername = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    required String userId,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt),
        userId = Value(userId);
  static Insertable<SettingsEntry> custom({
    Expression<String>? id,
    Expression<bool>? normalizeVolume,
    Expression<int>? crossfadeMs,
    Expression<bool>? scrobbleToLastFm,
    Expression<String>? lastFmSessionKey,
    Expression<String>? lastFmUsername,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? userId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (normalizeVolume != null) 'normalize_volume': normalizeVolume,
      if (crossfadeMs != null) 'crossfade_ms': crossfadeMs,
      if (scrobbleToLastFm != null) 'scrobble_to_last_fm': scrobbleToLastFm,
      if (lastFmSessionKey != null) 'last_fm_session_key': lastFmSessionKey,
      if (lastFmUsername != null) 'last_fm_username': lastFmUsername,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (userId != null) 'user_id': userId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SettingsEntriesCompanion copyWith(
      {Value<String>? id,
      Value<bool>? normalizeVolume,
      Value<int>? crossfadeMs,
      Value<bool>? scrobbleToLastFm,
      Value<String?>? lastFmSessionKey,
      Value<String?>? lastFmUsername,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<String>? userId,
      Value<int>? rowid}) {
    return SettingsEntriesCompanion(
      id: id ?? this.id,
      normalizeVolume: normalizeVolume ?? this.normalizeVolume,
      crossfadeMs: crossfadeMs ?? this.crossfadeMs,
      scrobbleToLastFm: scrobbleToLastFm ?? this.scrobbleToLastFm,
      lastFmSessionKey: lastFmSessionKey ?? this.lastFmSessionKey,
      lastFmUsername: lastFmUsername ?? this.lastFmUsername,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      userId: userId ?? this.userId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (normalizeVolume.present) {
      map['normalize_volume'] = Variable<bool>(normalizeVolume.value);
    }
    if (crossfadeMs.present) {
      map['crossfade_ms'] = Variable<int>(crossfadeMs.value);
    }
    if (scrobbleToLastFm.present) {
      map['scrobble_to_last_fm'] = Variable<bool>(scrobbleToLastFm.value);
    }
    if (lastFmSessionKey.present) {
      map['last_fm_session_key'] = Variable<String>(lastFmSessionKey.value);
    }
    if (lastFmUsername.present) {
      map['last_fm_username'] = Variable<String>(lastFmUsername.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsEntriesCompanion(')
          ..write('id: $id, ')
          ..write('normalizeVolume: $normalizeVolume, ')
          ..write('crossfadeMs: $crossfadeMs, ')
          ..write('scrobbleToLastFm: $scrobbleToLastFm, ')
          ..write('lastFmSessionKey: $lastFmSessionKey, ')
          ..write('lastFmUsername: $lastFmUsername, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('userId: $userId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TracksTable tracks = $TracksTable(this);
  late final $PlaylistsTable playlists = $PlaylistsTable(this);
  late final $PlaylistItemsTable playlistItems = $PlaylistItemsTable(this);
  late final $SettingsEntriesTable settingsEntries =
      $SettingsEntriesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [tracks, playlists, playlistItems, settingsEntries];
}

typedef $$TracksTableCreateCompanionBuilder = TracksCompanion Function({
  required String id,
  required String title,
  required String artist,
  required String album,
  required int durationMs,
  required String sourceUrl,
  Value<String?> artworkUrl,
  Value<String?> localPath,
  required DateTime createdAt,
  required DateTime updatedAt,
  required String userId,
  Value<int> rowid,
});
typedef $$TracksTableUpdateCompanionBuilder = TracksCompanion Function({
  Value<String> id,
  Value<String> title,
  Value<String> artist,
  Value<String> album,
  Value<int> durationMs,
  Value<String> sourceUrl,
  Value<String?> artworkUrl,
  Value<String?> localPath,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<String> userId,
  Value<int> rowid,
});

class $$TracksTableFilterComposer
    extends Composer<_$AppDatabase, $TracksTable> {
  $$TracksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get artist => $composableBuilder(
      column: $table.artist, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get album => $composableBuilder(
      column: $table.album, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get durationMs => $composableBuilder(
      column: $table.durationMs, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sourceUrl => $composableBuilder(
      column: $table.sourceUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get artworkUrl => $composableBuilder(
      column: $table.artworkUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get localPath => $composableBuilder(
      column: $table.localPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));
}

class $$TracksTableOrderingComposer
    extends Composer<_$AppDatabase, $TracksTable> {
  $$TracksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get artist => $composableBuilder(
      column: $table.artist, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get album => $composableBuilder(
      column: $table.album, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get durationMs => $composableBuilder(
      column: $table.durationMs, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sourceUrl => $composableBuilder(
      column: $table.sourceUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get artworkUrl => $composableBuilder(
      column: $table.artworkUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get localPath => $composableBuilder(
      column: $table.localPath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));
}

class $$TracksTableAnnotationComposer
    extends Composer<_$AppDatabase, $TracksTable> {
  $$TracksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get artist =>
      $composableBuilder(column: $table.artist, builder: (column) => column);

  GeneratedColumn<String> get album =>
      $composableBuilder(column: $table.album, builder: (column) => column);

  GeneratedColumn<int> get durationMs => $composableBuilder(
      column: $table.durationMs, builder: (column) => column);

  GeneratedColumn<String> get sourceUrl =>
      $composableBuilder(column: $table.sourceUrl, builder: (column) => column);

  GeneratedColumn<String> get artworkUrl => $composableBuilder(
      column: $table.artworkUrl, builder: (column) => column);

  GeneratedColumn<String> get localPath =>
      $composableBuilder(column: $table.localPath, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);
}

class $$TracksTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TracksTable,
    TrackRow,
    $$TracksTableFilterComposer,
    $$TracksTableOrderingComposer,
    $$TracksTableAnnotationComposer,
    $$TracksTableCreateCompanionBuilder,
    $$TracksTableUpdateCompanionBuilder,
    (TrackRow, BaseReferences<_$AppDatabase, $TracksTable, TrackRow>),
    TrackRow,
    PrefetchHooks Function()> {
  $$TracksTableTableManager(_$AppDatabase db, $TracksTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TracksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TracksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TracksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> artist = const Value.absent(),
            Value<String> album = const Value.absent(),
            Value<int> durationMs = const Value.absent(),
            Value<String> sourceUrl = const Value.absent(),
            Value<String?> artworkUrl = const Value.absent(),
            Value<String?> localPath = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TracksCompanion(
            id: id,
            title: title,
            artist: artist,
            album: album,
            durationMs: durationMs,
            sourceUrl: sourceUrl,
            artworkUrl: artworkUrl,
            localPath: localPath,
            createdAt: createdAt,
            updatedAt: updatedAt,
            userId: userId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String title,
            required String artist,
            required String album,
            required int durationMs,
            required String sourceUrl,
            Value<String?> artworkUrl = const Value.absent(),
            Value<String?> localPath = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            required String userId,
            Value<int> rowid = const Value.absent(),
          }) =>
              TracksCompanion.insert(
            id: id,
            title: title,
            artist: artist,
            album: album,
            durationMs: durationMs,
            sourceUrl: sourceUrl,
            artworkUrl: artworkUrl,
            localPath: localPath,
            createdAt: createdAt,
            updatedAt: updatedAt,
            userId: userId,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TracksTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TracksTable,
    TrackRow,
    $$TracksTableFilterComposer,
    $$TracksTableOrderingComposer,
    $$TracksTableAnnotationComposer,
    $$TracksTableCreateCompanionBuilder,
    $$TracksTableUpdateCompanionBuilder,
    (TrackRow, BaseReferences<_$AppDatabase, $TracksTable, TrackRow>),
    TrackRow,
    PrefetchHooks Function()>;
typedef $$PlaylistsTableCreateCompanionBuilder = PlaylistsCompanion Function({
  required String id,
  required String name,
  required DateTime createdAt,
  required DateTime updatedAt,
  required String userId,
  Value<int> rowid,
});
typedef $$PlaylistsTableUpdateCompanionBuilder = PlaylistsCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<String> userId,
  Value<int> rowid,
});

class $$PlaylistsTableFilterComposer
    extends Composer<_$AppDatabase, $PlaylistsTable> {
  $$PlaylistsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));
}

class $$PlaylistsTableOrderingComposer
    extends Composer<_$AppDatabase, $PlaylistsTable> {
  $$PlaylistsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));
}

class $$PlaylistsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlaylistsTable> {
  $$PlaylistsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);
}

class $$PlaylistsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PlaylistsTable,
    PlaylistRow,
    $$PlaylistsTableFilterComposer,
    $$PlaylistsTableOrderingComposer,
    $$PlaylistsTableAnnotationComposer,
    $$PlaylistsTableCreateCompanionBuilder,
    $$PlaylistsTableUpdateCompanionBuilder,
    (PlaylistRow, BaseReferences<_$AppDatabase, $PlaylistsTable, PlaylistRow>),
    PlaylistRow,
    PrefetchHooks Function()> {
  $$PlaylistsTableTableManager(_$AppDatabase db, $PlaylistsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlaylistsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlaylistsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlaylistsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PlaylistsCompanion(
            id: id,
            name: name,
            createdAt: createdAt,
            updatedAt: updatedAt,
            userId: userId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required DateTime createdAt,
            required DateTime updatedAt,
            required String userId,
            Value<int> rowid = const Value.absent(),
          }) =>
              PlaylistsCompanion.insert(
            id: id,
            name: name,
            createdAt: createdAt,
            updatedAt: updatedAt,
            userId: userId,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PlaylistsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PlaylistsTable,
    PlaylistRow,
    $$PlaylistsTableFilterComposer,
    $$PlaylistsTableOrderingComposer,
    $$PlaylistsTableAnnotationComposer,
    $$PlaylistsTableCreateCompanionBuilder,
    $$PlaylistsTableUpdateCompanionBuilder,
    (PlaylistRow, BaseReferences<_$AppDatabase, $PlaylistsTable, PlaylistRow>),
    PlaylistRow,
    PrefetchHooks Function()>;
typedef $$PlaylistItemsTableCreateCompanionBuilder = PlaylistItemsCompanion
    Function({
  required String id,
  required String playlistId,
  required String trackId,
  required int position,
  required DateTime createdAt,
  required DateTime updatedAt,
  required String userId,
  Value<int> rowid,
});
typedef $$PlaylistItemsTableUpdateCompanionBuilder = PlaylistItemsCompanion
    Function({
  Value<String> id,
  Value<String> playlistId,
  Value<String> trackId,
  Value<int> position,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<String> userId,
  Value<int> rowid,
});

class $$PlaylistItemsTableFilterComposer
    extends Composer<_$AppDatabase, $PlaylistItemsTable> {
  $$PlaylistItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get playlistId => $composableBuilder(
      column: $table.playlistId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get trackId => $composableBuilder(
      column: $table.trackId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get position => $composableBuilder(
      column: $table.position, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));
}

class $$PlaylistItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $PlaylistItemsTable> {
  $$PlaylistItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get playlistId => $composableBuilder(
      column: $table.playlistId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get trackId => $composableBuilder(
      column: $table.trackId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get position => $composableBuilder(
      column: $table.position, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));
}

class $$PlaylistItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlaylistItemsTable> {
  $$PlaylistItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get playlistId => $composableBuilder(
      column: $table.playlistId, builder: (column) => column);

  GeneratedColumn<String> get trackId =>
      $composableBuilder(column: $table.trackId, builder: (column) => column);

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);
}

class $$PlaylistItemsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PlaylistItemsTable,
    PlaylistItemRow,
    $$PlaylistItemsTableFilterComposer,
    $$PlaylistItemsTableOrderingComposer,
    $$PlaylistItemsTableAnnotationComposer,
    $$PlaylistItemsTableCreateCompanionBuilder,
    $$PlaylistItemsTableUpdateCompanionBuilder,
    (
      PlaylistItemRow,
      BaseReferences<_$AppDatabase, $PlaylistItemsTable, PlaylistItemRow>
    ),
    PlaylistItemRow,
    PrefetchHooks Function()> {
  $$PlaylistItemsTableTableManager(_$AppDatabase db, $PlaylistItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlaylistItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlaylistItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlaylistItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> playlistId = const Value.absent(),
            Value<String> trackId = const Value.absent(),
            Value<int> position = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PlaylistItemsCompanion(
            id: id,
            playlistId: playlistId,
            trackId: trackId,
            position: position,
            createdAt: createdAt,
            updatedAt: updatedAt,
            userId: userId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String playlistId,
            required String trackId,
            required int position,
            required DateTime createdAt,
            required DateTime updatedAt,
            required String userId,
            Value<int> rowid = const Value.absent(),
          }) =>
              PlaylistItemsCompanion.insert(
            id: id,
            playlistId: playlistId,
            trackId: trackId,
            position: position,
            createdAt: createdAt,
            updatedAt: updatedAt,
            userId: userId,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PlaylistItemsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PlaylistItemsTable,
    PlaylistItemRow,
    $$PlaylistItemsTableFilterComposer,
    $$PlaylistItemsTableOrderingComposer,
    $$PlaylistItemsTableAnnotationComposer,
    $$PlaylistItemsTableCreateCompanionBuilder,
    $$PlaylistItemsTableUpdateCompanionBuilder,
    (
      PlaylistItemRow,
      BaseReferences<_$AppDatabase, $PlaylistItemsTable, PlaylistItemRow>
    ),
    PlaylistItemRow,
    PrefetchHooks Function()>;
typedef $$SettingsEntriesTableCreateCompanionBuilder = SettingsEntriesCompanion
    Function({
  required String id,
  Value<bool> normalizeVolume,
  Value<int> crossfadeMs,
  Value<bool> scrobbleToLastFm,
  Value<String?> lastFmSessionKey,
  Value<String?> lastFmUsername,
  required DateTime createdAt,
  required DateTime updatedAt,
  required String userId,
  Value<int> rowid,
});
typedef $$SettingsEntriesTableUpdateCompanionBuilder = SettingsEntriesCompanion
    Function({
  Value<String> id,
  Value<bool> normalizeVolume,
  Value<int> crossfadeMs,
  Value<bool> scrobbleToLastFm,
  Value<String?> lastFmSessionKey,
  Value<String?> lastFmUsername,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<String> userId,
  Value<int> rowid,
});

class $$SettingsEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $SettingsEntriesTable> {
  $$SettingsEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get normalizeVolume => $composableBuilder(
      column: $table.normalizeVolume,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get crossfadeMs => $composableBuilder(
      column: $table.crossfadeMs, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get scrobbleToLastFm => $composableBuilder(
      column: $table.scrobbleToLastFm,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastFmSessionKey => $composableBuilder(
      column: $table.lastFmSessionKey,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastFmUsername => $composableBuilder(
      column: $table.lastFmUsername,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));
}

class $$SettingsEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $SettingsEntriesTable> {
  $$SettingsEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get normalizeVolume => $composableBuilder(
      column: $table.normalizeVolume,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get crossfadeMs => $composableBuilder(
      column: $table.crossfadeMs, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get scrobbleToLastFm => $composableBuilder(
      column: $table.scrobbleToLastFm,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastFmSessionKey => $composableBuilder(
      column: $table.lastFmSessionKey,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastFmUsername => $composableBuilder(
      column: $table.lastFmUsername,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));
}

class $$SettingsEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SettingsEntriesTable> {
  $$SettingsEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get normalizeVolume => $composableBuilder(
      column: $table.normalizeVolume, builder: (column) => column);

  GeneratedColumn<int> get crossfadeMs => $composableBuilder(
      column: $table.crossfadeMs, builder: (column) => column);

  GeneratedColumn<bool> get scrobbleToLastFm => $composableBuilder(
      column: $table.scrobbleToLastFm, builder: (column) => column);

  GeneratedColumn<String> get lastFmSessionKey => $composableBuilder(
      column: $table.lastFmSessionKey, builder: (column) => column);

  GeneratedColumn<String> get lastFmUsername => $composableBuilder(
      column: $table.lastFmUsername, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);
}

class $$SettingsEntriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SettingsEntriesTable,
    SettingsEntry,
    $$SettingsEntriesTableFilterComposer,
    $$SettingsEntriesTableOrderingComposer,
    $$SettingsEntriesTableAnnotationComposer,
    $$SettingsEntriesTableCreateCompanionBuilder,
    $$SettingsEntriesTableUpdateCompanionBuilder,
    (
      SettingsEntry,
      BaseReferences<_$AppDatabase, $SettingsEntriesTable, SettingsEntry>
    ),
    SettingsEntry,
    PrefetchHooks Function()> {
  $$SettingsEntriesTableTableManager(
      _$AppDatabase db, $SettingsEntriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SettingsEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SettingsEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SettingsEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<bool> normalizeVolume = const Value.absent(),
            Value<int> crossfadeMs = const Value.absent(),
            Value<bool> scrobbleToLastFm = const Value.absent(),
            Value<String?> lastFmSessionKey = const Value.absent(),
            Value<String?> lastFmUsername = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SettingsEntriesCompanion(
            id: id,
            normalizeVolume: normalizeVolume,
            crossfadeMs: crossfadeMs,
            scrobbleToLastFm: scrobbleToLastFm,
            lastFmSessionKey: lastFmSessionKey,
            lastFmUsername: lastFmUsername,
            createdAt: createdAt,
            updatedAt: updatedAt,
            userId: userId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<bool> normalizeVolume = const Value.absent(),
            Value<int> crossfadeMs = const Value.absent(),
            Value<bool> scrobbleToLastFm = const Value.absent(),
            Value<String?> lastFmSessionKey = const Value.absent(),
            Value<String?> lastFmUsername = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            required String userId,
            Value<int> rowid = const Value.absent(),
          }) =>
              SettingsEntriesCompanion.insert(
            id: id,
            normalizeVolume: normalizeVolume,
            crossfadeMs: crossfadeMs,
            scrobbleToLastFm: scrobbleToLastFm,
            lastFmSessionKey: lastFmSessionKey,
            lastFmUsername: lastFmUsername,
            createdAt: createdAt,
            updatedAt: updatedAt,
            userId: userId,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SettingsEntriesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SettingsEntriesTable,
    SettingsEntry,
    $$SettingsEntriesTableFilterComposer,
    $$SettingsEntriesTableOrderingComposer,
    $$SettingsEntriesTableAnnotationComposer,
    $$SettingsEntriesTableCreateCompanionBuilder,
    $$SettingsEntriesTableUpdateCompanionBuilder,
    (
      SettingsEntry,
      BaseReferences<_$AppDatabase, $SettingsEntriesTable, SettingsEntry>
    ),
    SettingsEntry,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TracksTableTableManager get tracks =>
      $$TracksTableTableManager(_db, _db.tracks);
  $$PlaylistsTableTableManager get playlists =>
      $$PlaylistsTableTableManager(_db, _db.playlists);
  $$PlaylistItemsTableTableManager get playlistItems =>
      $$PlaylistItemsTableTableManager(_db, _db.playlistItems);
  $$SettingsEntriesTableTableManager get settingsEntries =>
      $$SettingsEntriesTableTableManager(_db, _db.settingsEntries);
}
