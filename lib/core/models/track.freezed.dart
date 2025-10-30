// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'track.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Track _$TrackFromJson(Map<String, dynamic> json) {
  return _Track.fromJson(json);
}

/// @nodoc
mixin _$Track {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get artist => throw _privateConstructorUsedError;
  String get album => throw _privateConstructorUsedError;
  int get durationMs => throw _privateConstructorUsedError;
  String get sourceUrl => throw _privateConstructorUsedError;
  String? get artworkUrl => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false)
  String? get localPath => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;

  /// Serializes this Track to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Track
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TrackCopyWith<Track> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrackCopyWith<$Res> {
  factory $TrackCopyWith(Track value, $Res Function(Track) then) =
      _$TrackCopyWithImpl<$Res, Track>;
  @useResult
  $Res call(
      {String id,
      String title,
      String artist,
      String album,
      int durationMs,
      String sourceUrl,
      String? artworkUrl,
      @JsonKey(includeIfNull: false) String? localPath,
      DateTime createdAt,
      DateTime updatedAt,
      String userId});
}

/// @nodoc
class _$TrackCopyWithImpl<$Res, $Val extends Track>
    implements $TrackCopyWith<$Res> {
  _$TrackCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      artist: null == artist
          ? _value.artist
          : artist // ignore: cast_nullable_to_non_nullable
              as String,
      album: null == album
          ? _value.album
          : album // ignore: cast_nullable_to_non_nullable
              as String,
      durationMs: null == durationMs
          ? _value.durationMs
          : durationMs // ignore: cast_nullable_to_non_nullable
              as int,
      sourceUrl: null == sourceUrl
          ? _value.sourceUrl
          : sourceUrl // ignore: cast_nullable_to_non_nullable
              as String,
      artworkUrl: freezed == artworkUrl
          ? _value.artworkUrl
          : artworkUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      localPath: freezed == localPath
          ? _value.localPath
          : localPath // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TrackImplCopyWith<$Res> implements $TrackCopyWith<$Res> {
  factory _$$TrackImplCopyWith(
          _$TrackImpl value, $Res Function(_$TrackImpl) then) =
      __$$TrackImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String artist,
      String album,
      int durationMs,
      String sourceUrl,
      String? artworkUrl,
      @JsonKey(includeIfNull: false) String? localPath,
      DateTime createdAt,
      DateTime updatedAt,
      String userId});
}

/// @nodoc
class __$$TrackImplCopyWithImpl<$Res>
    extends _$TrackCopyWithImpl<$Res, _$TrackImpl>
    implements _$$TrackImplCopyWith<$Res> {
  __$$TrackImplCopyWithImpl(
      _$TrackImpl _value, $Res Function(_$TrackImpl) _then)
      : super(_value, _then);

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
    return _then(_$TrackImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      artist: null == artist
          ? _value.artist
          : artist // ignore: cast_nullable_to_non_nullable
              as String,
      album: null == album
          ? _value.album
          : album // ignore: cast_nullable_to_non_nullable
              as String,
      durationMs: null == durationMs
          ? _value.durationMs
          : durationMs // ignore: cast_nullable_to_non_nullable
              as int,
      sourceUrl: null == sourceUrl
          ? _value.sourceUrl
          : sourceUrl // ignore: cast_nullable_to_non_nullable
              as String,
      artworkUrl: freezed == artworkUrl
          ? _value.artworkUrl
          : artworkUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      localPath: freezed == localPath
          ? _value.localPath
          : localPath // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TrackImpl implements _Track {
  const _$TrackImpl(
      {required this.id,
      required this.title,
      required this.artist,
      required this.album,
      required this.durationMs,
      required this.sourceUrl,
      this.artworkUrl,
      @JsonKey(includeIfNull: false) this.localPath,
      required this.createdAt,
      required this.updatedAt,
      required this.userId});

  factory _$TrackImpl.fromJson(Map<String, dynamic> json) =>
      _$$TrackImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String artist;
  @override
  final String album;
  @override
  final int durationMs;
  @override
  final String sourceUrl;
  @override
  final String? artworkUrl;
  @override
  @JsonKey(includeIfNull: false)
  final String? localPath;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final String userId;

  @override
  String toString() {
    return 'Track(id: $id, title: $title, artist: $artist, album: $album, durationMs: $durationMs, sourceUrl: $sourceUrl, artworkUrl: $artworkUrl, localPath: $localPath, createdAt: $createdAt, updatedAt: $updatedAt, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrackImpl &&
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

  /// Create a copy of Track
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TrackImplCopyWith<_$TrackImpl> get copyWith =>
      __$$TrackImplCopyWithImpl<_$TrackImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TrackImplToJson(
      this,
    );
  }
}

abstract class _Track implements Track {
  const factory _Track(
      {required final String id,
      required final String title,
      required final String artist,
      required final String album,
      required final int durationMs,
      required final String sourceUrl,
      final String? artworkUrl,
      @JsonKey(includeIfNull: false) final String? localPath,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      required final String userId}) = _$TrackImpl;

  factory _Track.fromJson(Map<String, dynamic> json) = _$TrackImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get artist;
  @override
  String get album;
  @override
  int get durationMs;
  @override
  String get sourceUrl;
  @override
  String? get artworkUrl;
  @override
  @JsonKey(includeIfNull: false)
  String? get localPath;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  String get userId;

  /// Create a copy of Track
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TrackImplCopyWith<_$TrackImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
