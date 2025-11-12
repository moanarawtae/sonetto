// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'playlist_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlaylistItem {
  String get id;
  @JsonKey(name: 'playlist_id')
  String get playlistId;
  @JsonKey(name: 'track_id')
  String get trackId;
  int get position;
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt;
  @JsonKey(name: 'user_id')
  String get userId;

  /// Create a copy of PlaylistItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PlaylistItemCopyWith<PlaylistItem> get copyWith =>
      _$PlaylistItemCopyWithImpl<PlaylistItem>(
          this as PlaylistItem, _$identity);

  /// Serializes this PlaylistItem to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PlaylistItem &&
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

  @override
  String toString() {
    return 'PlaylistItem(id: $id, playlistId: $playlistId, trackId: $trackId, position: $position, createdAt: $createdAt, updatedAt: $updatedAt, userId: $userId)';
  }
}

/// @nodoc
abstract mixin class $PlaylistItemCopyWith<$Res> {
  factory $PlaylistItemCopyWith(
          PlaylistItem value, $Res Function(PlaylistItem) _then) =
      _$PlaylistItemCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'playlist_id') String playlistId,
      @JsonKey(name: 'track_id') String trackId,
      int position,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'updated_at') DateTime updatedAt,
      @JsonKey(name: 'user_id') String userId});
}

/// @nodoc
class _$PlaylistItemCopyWithImpl<$Res> implements $PlaylistItemCopyWith<$Res> {
  _$PlaylistItemCopyWithImpl(this._self, this._then);

  final PlaylistItem _self;
  final $Res Function(PlaylistItem) _then;

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
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      playlistId: null == playlistId
          ? _self.playlistId
          : playlistId // ignore: cast_nullable_to_non_nullable
              as String,
      trackId: null == trackId
          ? _self.trackId
          : trackId // ignore: cast_nullable_to_non_nullable
              as String,
      position: null == position
          ? _self.position
          : position // ignore: cast_nullable_to_non_nullable
              as int,
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

/// Adds pattern-matching-related methods to [PlaylistItem].
extension PlaylistItemPatterns on PlaylistItem {
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
    TResult Function(_PlaylistItem value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PlaylistItem() when $default != null:
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
    TResult Function(_PlaylistItem value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PlaylistItem():
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
    TResult? Function(_PlaylistItem value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PlaylistItem() when $default != null:
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
            @JsonKey(name: 'playlist_id') String playlistId,
            @JsonKey(name: 'track_id') String trackId,
            int position,
            @JsonKey(name: 'created_at') DateTime createdAt,
            @JsonKey(name: 'updated_at') DateTime updatedAt,
            @JsonKey(name: 'user_id') String userId)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PlaylistItem() when $default != null:
        return $default(_that.id, _that.playlistId, _that.trackId,
            _that.position, _that.createdAt, _that.updatedAt, _that.userId);
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
            @JsonKey(name: 'playlist_id') String playlistId,
            @JsonKey(name: 'track_id') String trackId,
            int position,
            @JsonKey(name: 'created_at') DateTime createdAt,
            @JsonKey(name: 'updated_at') DateTime updatedAt,
            @JsonKey(name: 'user_id') String userId)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PlaylistItem():
        return $default(_that.id, _that.playlistId, _that.trackId,
            _that.position, _that.createdAt, _that.updatedAt, _that.userId);
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
            @JsonKey(name: 'playlist_id') String playlistId,
            @JsonKey(name: 'track_id') String trackId,
            int position,
            @JsonKey(name: 'created_at') DateTime createdAt,
            @JsonKey(name: 'updated_at') DateTime updatedAt,
            @JsonKey(name: 'user_id') String userId)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PlaylistItem() when $default != null:
        return $default(_that.id, _that.playlistId, _that.trackId,
            _that.position, _that.createdAt, _that.updatedAt, _that.userId);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _PlaylistItem implements PlaylistItem {
  const _PlaylistItem(
      {required this.id,
      @JsonKey(name: 'playlist_id') required this.playlistId,
      @JsonKey(name: 'track_id') required this.trackId,
      required this.position,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'updated_at') required this.updatedAt,
      @JsonKey(name: 'user_id') required this.userId});
  factory _PlaylistItem.fromJson(Map<String, dynamic> json) =>
      _$PlaylistItemFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'playlist_id')
  final String playlistId;
  @override
  @JsonKey(name: 'track_id')
  final String trackId;
  @override
  final int position;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  @override
  @JsonKey(name: 'user_id')
  final String userId;

  /// Create a copy of PlaylistItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PlaylistItemCopyWith<_PlaylistItem> get copyWith =>
      __$PlaylistItemCopyWithImpl<_PlaylistItem>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PlaylistItemToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PlaylistItem &&
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

  @override
  String toString() {
    return 'PlaylistItem(id: $id, playlistId: $playlistId, trackId: $trackId, position: $position, createdAt: $createdAt, updatedAt: $updatedAt, userId: $userId)';
  }
}

/// @nodoc
abstract mixin class _$PlaylistItemCopyWith<$Res>
    implements $PlaylistItemCopyWith<$Res> {
  factory _$PlaylistItemCopyWith(
          _PlaylistItem value, $Res Function(_PlaylistItem) _then) =
      __$PlaylistItemCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'playlist_id') String playlistId,
      @JsonKey(name: 'track_id') String trackId,
      int position,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'updated_at') DateTime updatedAt,
      @JsonKey(name: 'user_id') String userId});
}

/// @nodoc
class __$PlaylistItemCopyWithImpl<$Res>
    implements _$PlaylistItemCopyWith<$Res> {
  __$PlaylistItemCopyWithImpl(this._self, this._then);

  final _PlaylistItem _self;
  final $Res Function(_PlaylistItem) _then;

  /// Create a copy of PlaylistItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? playlistId = null,
    Object? trackId = null,
    Object? position = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? userId = null,
  }) {
    return _then(_PlaylistItem(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      playlistId: null == playlistId
          ? _self.playlistId
          : playlistId // ignore: cast_nullable_to_non_nullable
              as String,
      trackId: null == trackId
          ? _self.trackId
          : trackId // ignore: cast_nullable_to_non_nullable
              as String,
      position: null == position
          ? _self.position
          : position // ignore: cast_nullable_to_non_nullable
              as int,
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
