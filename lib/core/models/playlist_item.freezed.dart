// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'playlist_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PlaylistItem _$PlaylistItemFromJson(Map<String, dynamic> json) {
  return _PlaylistItem.fromJson(json);
}

/// @nodoc
mixin _$PlaylistItem {
  String get id => throw _privateConstructorUsedError;
  String get playlistId => throw _privateConstructorUsedError;
  String get trackId => throw _privateConstructorUsedError;
  int get position => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;

  /// Serializes this PlaylistItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PlaylistItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlaylistItemCopyWith<PlaylistItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlaylistItemCopyWith<$Res> {
  factory $PlaylistItemCopyWith(
          PlaylistItem value, $Res Function(PlaylistItem) then) =
      _$PlaylistItemCopyWithImpl<$Res, PlaylistItem>;
  @useResult
  $Res call(
      {String id,
      String playlistId,
      String trackId,
      int position,
      DateTime createdAt,
      DateTime updatedAt,
      String userId});
}

/// @nodoc
class _$PlaylistItemCopyWithImpl<$Res, $Val extends PlaylistItem>
    implements $PlaylistItemCopyWith<$Res> {
  _$PlaylistItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlaylistItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? playlistId = null,
    Object? trackId = null,
    Object? position = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? userId = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      playlistId: null == playlistId
          ? _value.playlistId
          : playlistId // ignore: cast_nullable_to_non_nullable
              as String,
      trackId: null == trackId
          ? _value.trackId
          : trackId // ignore: cast_nullable_to_non_nullable
              as String,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as int,
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
abstract class _$$PlaylistItemImplCopyWith<$Res>
    implements $PlaylistItemCopyWith<$Res> {
  factory _$$PlaylistItemImplCopyWith(
          _$PlaylistItemImpl value, $Res Function(_$PlaylistItemImpl) then) =
      __$$PlaylistItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String playlistId,
      String trackId,
      int position,
      DateTime createdAt,
      DateTime updatedAt,
      String userId});
}

/// @nodoc
class __$$PlaylistItemImplCopyWithImpl<$Res>
    extends _$PlaylistItemCopyWithImpl<$Res, _$PlaylistItemImpl>
    implements _$$PlaylistItemImplCopyWith<$Res> {
  __$$PlaylistItemImplCopyWithImpl(
      _$PlaylistItemImpl _value, $Res Function(_$PlaylistItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of PlaylistItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? playlistId = null,
    Object? trackId = null,
    Object? position = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? userId = null,
  }) {
    return _then(_$PlaylistItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      playlistId: null == playlistId
          ? _value.playlistId
          : playlistId // ignore: cast_nullable_to_non_nullable
              as String,
      trackId: null == trackId
          ? _value.trackId
          : trackId // ignore: cast_nullable_to_non_nullable
              as String,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as int,
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
class _$PlaylistItemImpl implements _PlaylistItem {
  const _$PlaylistItemImpl(
      {required this.id,
      required this.playlistId,
      required this.trackId,
      required this.position,
      required this.createdAt,
      required this.updatedAt,
      required this.userId});

  factory _$PlaylistItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlaylistItemImplFromJson(json);

  @override
  final String id;
  @override
  final String playlistId;
  @override
  final String trackId;
  @override
  final int position;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final String userId;

  @override
  String toString() {
    return 'PlaylistItem(id: $id, playlistId: $playlistId, trackId: $trackId, position: $position, createdAt: $createdAt, updatedAt: $updatedAt, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlaylistItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.playlistId, playlistId) ||
                other.playlistId == playlistId) &&
            (identical(other.trackId, trackId) || other.trackId == trackId) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, playlistId, trackId,
      position, createdAt, updatedAt, userId);

  /// Create a copy of PlaylistItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlaylistItemImplCopyWith<_$PlaylistItemImpl> get copyWith =>
      __$$PlaylistItemImplCopyWithImpl<_$PlaylistItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlaylistItemImplToJson(
      this,
    );
  }
}

abstract class _PlaylistItem implements PlaylistItem {
  const factory _PlaylistItem(
      {required final String id,
      required final String playlistId,
      required final String trackId,
      required final int position,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      required final String userId}) = _$PlaylistItemImpl;

  factory _PlaylistItem.fromJson(Map<String, dynamic> json) =
      _$PlaylistItemImpl.fromJson;

  @override
  String get id;
  @override
  String get playlistId;
  @override
  String get trackId;
  @override
  int get position;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  String get userId;

  /// Create a copy of PlaylistItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlaylistItemImplCopyWith<_$PlaylistItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
