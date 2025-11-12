// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'track.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Track {
  String get id;
  String get title;
  String get artist;
  String get album;
  @JsonKey(name: 'duration_ms')
  int get durationMs;
  @JsonKey(name: 'source_url')
  String get sourceUrl;
  @JsonKey(name: 'artwork_url')
  String? get artworkUrl;
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? get localPath;
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt;
  @JsonKey(name: 'user_id')
  String get userId;

  /// Create a copy of Track
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TrackCopyWith<Track> get copyWith =>
      _$TrackCopyWithImpl<Track>(this as Track, _$identity);

  /// Serializes this Track to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Track &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.artist, artist) || other.artist == artist) &&
            (identical(other.album, album) || other.album == album) &&
            (identical(other.durationMs, durationMs) ||
                other.durationMs == durationMs) &&
            (identical(other.sourceUrl, sourceUrl) ||
                other.sourceUrl == sourceUrl) &&
            (identical(other.artworkUrl, artworkUrl) ||
                other.artworkUrl == artworkUrl) &&
            (identical(other.localPath, localPath) ||
                other.localPath == localPath) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
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
      userId);

  @override
  String toString() {
    return 'Track(id: $id, title: $title, artist: $artist, album: $album, durationMs: $durationMs, sourceUrl: $sourceUrl, artworkUrl: $artworkUrl, localPath: $localPath, createdAt: $createdAt, updatedAt: $updatedAt, userId: $userId)';
  }
}

/// @nodoc
abstract mixin class $TrackCopyWith<$Res> {
  factory $TrackCopyWith(Track value, $Res Function(Track) _then) =
      _$TrackCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String title,
      String artist,
      String album,
      @JsonKey(name: 'duration_ms') int durationMs,
      @JsonKey(name: 'source_url') String sourceUrl,
      @JsonKey(name: 'artwork_url') String? artworkUrl,
      @JsonKey(includeFromJson: false, includeToJson: false) String? localPath,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'updated_at') DateTime updatedAt,
      @JsonKey(name: 'user_id') String userId});
}

/// @nodoc
class _$TrackCopyWithImpl<$Res> implements $TrackCopyWith<$Res> {
  _$TrackCopyWithImpl(this._self, this._then);

  final Track _self;
  final $Res Function(Track) _then;

  /// Create a copy of Track
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? artist = null,
    Object? album = null,
    Object? durationMs = null,
    Object? sourceUrl = null,
    Object? artworkUrl = freezed,
    Object? localPath = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? userId = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      artist: null == artist
          ? _self.artist
          : artist // ignore: cast_nullable_to_non_nullable
              as String,
      album: null == album
          ? _self.album
          : album // ignore: cast_nullable_to_non_nullable
              as String,
      durationMs: null == durationMs
          ? _self.durationMs
          : durationMs // ignore: cast_nullable_to_non_nullable
              as int,
      sourceUrl: null == sourceUrl
          ? _self.sourceUrl
          : sourceUrl // ignore: cast_nullable_to_non_nullable
              as String,
      artworkUrl: freezed == artworkUrl
          ? _self.artworkUrl
          : artworkUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      localPath: freezed == localPath
          ? _self.localPath
          : localPath // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [Track].
extension TrackPatterns on Track {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Track value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Track() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Track value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Track():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Track value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Track() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            String title,
            String artist,
            String album,
            @JsonKey(name: 'duration_ms') int durationMs,
            @JsonKey(name: 'source_url') String sourceUrl,
            @JsonKey(name: 'artwork_url') String? artworkUrl,
            @JsonKey(includeFromJson: false, includeToJson: false)
            String? localPath,
            @JsonKey(name: 'created_at') DateTime createdAt,
            @JsonKey(name: 'updated_at') DateTime updatedAt,
            @JsonKey(name: 'user_id') String userId)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Track() when $default != null:
        return $default(
            _that.id,
            _that.title,
            _that.artist,
            _that.album,
            _that.durationMs,
            _that.sourceUrl,
            _that.artworkUrl,
            _that.localPath,
            _that.createdAt,
            _that.updatedAt,
            _that.userId);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            String title,
            String artist,
            String album,
            @JsonKey(name: 'duration_ms') int durationMs,
            @JsonKey(name: 'source_url') String sourceUrl,
            @JsonKey(name: 'artwork_url') String? artworkUrl,
            @JsonKey(includeFromJson: false, includeToJson: false)
            String? localPath,
            @JsonKey(name: 'created_at') DateTime createdAt,
            @JsonKey(name: 'updated_at') DateTime updatedAt,
            @JsonKey(name: 'user_id') String userId)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Track():
        return $default(
            _that.id,
            _that.title,
            _that.artist,
            _that.album,
            _that.durationMs,
            _that.sourceUrl,
            _that.artworkUrl,
            _that.localPath,
            _that.createdAt,
            _that.updatedAt,
            _that.userId);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            String title,
            String artist,
            String album,
            @JsonKey(name: 'duration_ms') int durationMs,
            @JsonKey(name: 'source_url') String sourceUrl,
            @JsonKey(name: 'artwork_url') String? artworkUrl,
            @JsonKey(includeFromJson: false, includeToJson: false)
            String? localPath,
            @JsonKey(name: 'created_at') DateTime createdAt,
            @JsonKey(name: 'updated_at') DateTime updatedAt,
            @JsonKey(name: 'user_id') String userId)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Track() when $default != null:
        return $default(
            _that.id,
            _that.title,
            _that.artist,
            _that.album,
            _that.durationMs,
            _that.sourceUrl,
            _that.artworkUrl,
            _that.localPath,
            _that.createdAt,
            _that.updatedAt,
            _that.userId);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Track implements Track {
  const _Track(
      {required this.id,
      required this.title,
      required this.artist,
      required this.album,
      @JsonKey(name: 'duration_ms') required this.durationMs,
      @JsonKey(name: 'source_url') required this.sourceUrl,
      @JsonKey(name: 'artwork_url') this.artworkUrl,
      @JsonKey(includeFromJson: false, includeToJson: false) this.localPath,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'updated_at') required this.updatedAt,
      @JsonKey(name: 'user_id') required this.userId});
  factory _Track.fromJson(Map<String, dynamic> json) => _$TrackFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String artist;
  @override
  final String album;
  @override
  @JsonKey(name: 'duration_ms')
  final int durationMs;
  @override
  @JsonKey(name: 'source_url')
  final String sourceUrl;
  @override
  @JsonKey(name: 'artwork_url')
  final String? artworkUrl;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String? localPath;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  @override
  @JsonKey(name: 'user_id')
  final String userId;

  /// Create a copy of Track
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TrackCopyWith<_Track> get copyWith =>
      __$TrackCopyWithImpl<_Track>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TrackToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Track &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.artist, artist) || other.artist == artist) &&
            (identical(other.album, album) || other.album == album) &&
            (identical(other.durationMs, durationMs) ||
                other.durationMs == durationMs) &&
            (identical(other.sourceUrl, sourceUrl) ||
                other.sourceUrl == sourceUrl) &&
            (identical(other.artworkUrl, artworkUrl) ||
                other.artworkUrl == artworkUrl) &&
            (identical(other.localPath, localPath) ||
                other.localPath == localPath) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
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
      userId);

  @override
  String toString() {
    return 'Track(id: $id, title: $title, artist: $artist, album: $album, durationMs: $durationMs, sourceUrl: $sourceUrl, artworkUrl: $artworkUrl, localPath: $localPath, createdAt: $createdAt, updatedAt: $updatedAt, userId: $userId)';
  }
}

/// @nodoc
abstract mixin class _$TrackCopyWith<$Res> implements $TrackCopyWith<$Res> {
  factory _$TrackCopyWith(_Track value, $Res Function(_Track) _then) =
      __$TrackCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String artist,
      String album,
      @JsonKey(name: 'duration_ms') int durationMs,
      @JsonKey(name: 'source_url') String sourceUrl,
      @JsonKey(name: 'artwork_url') String? artworkUrl,
      @JsonKey(includeFromJson: false, includeToJson: false) String? localPath,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'updated_at') DateTime updatedAt,
      @JsonKey(name: 'user_id') String userId});
}

/// @nodoc
class __$TrackCopyWithImpl<$Res> implements _$TrackCopyWith<$Res> {
  __$TrackCopyWithImpl(this._self, this._then);

  final _Track _self;
  final $Res Function(_Track) _then;

  /// Create a copy of Track
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? artist = null,
    Object? album = null,
    Object? durationMs = null,
    Object? sourceUrl = null,
    Object? artworkUrl = freezed,
    Object? localPath = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? userId = null,
  }) {
    return _then(_Track(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      artist: null == artist
          ? _self.artist
          : artist // ignore: cast_nullable_to_non_nullable
              as String,
      album: null == album
          ? _self.album
          : album // ignore: cast_nullable_to_non_nullable
              as String,
      durationMs: null == durationMs
          ? _self.durationMs
          : durationMs // ignore: cast_nullable_to_non_nullable
              as int,
      sourceUrl: null == sourceUrl
          ? _self.sourceUrl
          : sourceUrl // ignore: cast_nullable_to_non_nullable
              as String,
      artworkUrl: freezed == artworkUrl
          ? _self.artworkUrl
          : artworkUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      localPath: freezed == localPath
          ? _self.localPath
          : localPath // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
