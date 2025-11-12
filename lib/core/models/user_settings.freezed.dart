// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserSettings {
  String get id;
  @JsonKey(name: 'normalize_volume')
  bool get normalizeVolume;
  @JsonKey(name: 'crossfade_ms')
  int get crossfadeMs;
  @JsonKey(name: 'scrobble_to_lastfm')
  bool get scrobbleToLastFm;
  @JsonKey(name: 'lastfm_session_key')
  String? get lastFmSessionKey;
  @JsonKey(name: 'lastfm_username')
  String? get lastFmUsername;
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt;
  @JsonKey(name: 'user_id')
  String get userId;

  /// Create a copy of UserSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UserSettingsCopyWith<UserSettings> get copyWith =>
      _$UserSettingsCopyWithImpl<UserSettings>(
          this as UserSettings, _$identity);

  /// Serializes this UserSettings to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UserSettings &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.normalizeVolume, normalizeVolume) ||
                other.normalizeVolume == normalizeVolume) &&
            (identical(other.crossfadeMs, crossfadeMs) ||
                other.crossfadeMs == crossfadeMs) &&
            (identical(other.scrobbleToLastFm, scrobbleToLastFm) ||
                other.scrobbleToLastFm == scrobbleToLastFm) &&
            (identical(other.lastFmSessionKey, lastFmSessionKey) ||
                other.lastFmSessionKey == lastFmSessionKey) &&
            (identical(other.lastFmUsername, lastFmUsername) ||
                other.lastFmUsername == lastFmUsername) &&
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
      normalizeVolume,
      crossfadeMs,
      scrobbleToLastFm,
      lastFmSessionKey,
      lastFmUsername,
      createdAt,
      updatedAt,
      userId);

  @override
  String toString() {
    return 'UserSettings(id: $id, normalizeVolume: $normalizeVolume, crossfadeMs: $crossfadeMs, scrobbleToLastFm: $scrobbleToLastFm, lastFmSessionKey: $lastFmSessionKey, lastFmUsername: $lastFmUsername, createdAt: $createdAt, updatedAt: $updatedAt, userId: $userId)';
  }
}

/// @nodoc
abstract mixin class $UserSettingsCopyWith<$Res> {
  factory $UserSettingsCopyWith(
          UserSettings value, $Res Function(UserSettings) _then) =
      _$UserSettingsCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'normalize_volume') bool normalizeVolume,
      @JsonKey(name: 'crossfade_ms') int crossfadeMs,
      @JsonKey(name: 'scrobble_to_lastfm') bool scrobbleToLastFm,
      @JsonKey(name: 'lastfm_session_key') String? lastFmSessionKey,
      @JsonKey(name: 'lastfm_username') String? lastFmUsername,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'updated_at') DateTime updatedAt,
      @JsonKey(name: 'user_id') String userId});
}

/// @nodoc
class _$UserSettingsCopyWithImpl<$Res> implements $UserSettingsCopyWith<$Res> {
  _$UserSettingsCopyWithImpl(this._self, this._then);

  final UserSettings _self;
  final $Res Function(UserSettings) _then;

  /// Create a copy of UserSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? normalizeVolume = null,
    Object? crossfadeMs = null,
    Object? scrobbleToLastFm = null,
    Object? lastFmSessionKey = freezed,
    Object? lastFmUsername = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? userId = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      normalizeVolume: null == normalizeVolume
          ? _self.normalizeVolume
          : normalizeVolume // ignore: cast_nullable_to_non_nullable
              as bool,
      crossfadeMs: null == crossfadeMs
          ? _self.crossfadeMs
          : crossfadeMs // ignore: cast_nullable_to_non_nullable
              as int,
      scrobbleToLastFm: null == scrobbleToLastFm
          ? _self.scrobbleToLastFm
          : scrobbleToLastFm // ignore: cast_nullable_to_non_nullable
              as bool,
      lastFmSessionKey: freezed == lastFmSessionKey
          ? _self.lastFmSessionKey
          : lastFmSessionKey // ignore: cast_nullable_to_non_nullable
              as String?,
      lastFmUsername: freezed == lastFmUsername
          ? _self.lastFmUsername
          : lastFmUsername // ignore: cast_nullable_to_non_nullable
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

/// Adds pattern-matching-related methods to [UserSettings].
extension UserSettingsPatterns on UserSettings {
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
    TResult Function(_UserSettings value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UserSettings() when $default != null:
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
    TResult Function(_UserSettings value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserSettings():
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
    TResult? Function(_UserSettings value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserSettings() when $default != null:
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
            @JsonKey(name: 'normalize_volume') bool normalizeVolume,
            @JsonKey(name: 'crossfade_ms') int crossfadeMs,
            @JsonKey(name: 'scrobble_to_lastfm') bool scrobbleToLastFm,
            @JsonKey(name: 'lastfm_session_key') String? lastFmSessionKey,
            @JsonKey(name: 'lastfm_username') String? lastFmUsername,
            @JsonKey(name: 'created_at') DateTime createdAt,
            @JsonKey(name: 'updated_at') DateTime updatedAt,
            @JsonKey(name: 'user_id') String userId)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UserSettings() when $default != null:
        return $default(
            _that.id,
            _that.normalizeVolume,
            _that.crossfadeMs,
            _that.scrobbleToLastFm,
            _that.lastFmSessionKey,
            _that.lastFmUsername,
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
            @JsonKey(name: 'normalize_volume') bool normalizeVolume,
            @JsonKey(name: 'crossfade_ms') int crossfadeMs,
            @JsonKey(name: 'scrobble_to_lastfm') bool scrobbleToLastFm,
            @JsonKey(name: 'lastfm_session_key') String? lastFmSessionKey,
            @JsonKey(name: 'lastfm_username') String? lastFmUsername,
            @JsonKey(name: 'created_at') DateTime createdAt,
            @JsonKey(name: 'updated_at') DateTime updatedAt,
            @JsonKey(name: 'user_id') String userId)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserSettings():
        return $default(
            _that.id,
            _that.normalizeVolume,
            _that.crossfadeMs,
            _that.scrobbleToLastFm,
            _that.lastFmSessionKey,
            _that.lastFmUsername,
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
            @JsonKey(name: 'normalize_volume') bool normalizeVolume,
            @JsonKey(name: 'crossfade_ms') int crossfadeMs,
            @JsonKey(name: 'scrobble_to_lastfm') bool scrobbleToLastFm,
            @JsonKey(name: 'lastfm_session_key') String? lastFmSessionKey,
            @JsonKey(name: 'lastfm_username') String? lastFmUsername,
            @JsonKey(name: 'created_at') DateTime createdAt,
            @JsonKey(name: 'updated_at') DateTime updatedAt,
            @JsonKey(name: 'user_id') String userId)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserSettings() when $default != null:
        return $default(
            _that.id,
            _that.normalizeVolume,
            _that.crossfadeMs,
            _that.scrobbleToLastFm,
            _that.lastFmSessionKey,
            _that.lastFmUsername,
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
class _UserSettings implements UserSettings {
  const _UserSettings(
      {required this.id,
      @JsonKey(name: 'normalize_volume') required this.normalizeVolume,
      @JsonKey(name: 'crossfade_ms') required this.crossfadeMs,
      @JsonKey(name: 'scrobble_to_lastfm') this.scrobbleToLastFm = false,
      @JsonKey(name: 'lastfm_session_key') this.lastFmSessionKey,
      @JsonKey(name: 'lastfm_username') this.lastFmUsername,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'updated_at') required this.updatedAt,
      @JsonKey(name: 'user_id') required this.userId});
  factory _UserSettings.fromJson(Map<String, dynamic> json) =>
      _$UserSettingsFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'normalize_volume')
  final bool normalizeVolume;
  @override
  @JsonKey(name: 'crossfade_ms')
  final int crossfadeMs;
  @override
  @JsonKey(name: 'scrobble_to_lastfm')
  final bool scrobbleToLastFm;
  @override
  @JsonKey(name: 'lastfm_session_key')
  final String? lastFmSessionKey;
  @override
  @JsonKey(name: 'lastfm_username')
  final String? lastFmUsername;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  @override
  @JsonKey(name: 'user_id')
  final String userId;

  /// Create a copy of UserSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UserSettingsCopyWith<_UserSettings> get copyWith =>
      __$UserSettingsCopyWithImpl<_UserSettings>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UserSettingsToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UserSettings &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.normalizeVolume, normalizeVolume) ||
                other.normalizeVolume == normalizeVolume) &&
            (identical(other.crossfadeMs, crossfadeMs) ||
                other.crossfadeMs == crossfadeMs) &&
            (identical(other.scrobbleToLastFm, scrobbleToLastFm) ||
                other.scrobbleToLastFm == scrobbleToLastFm) &&
            (identical(other.lastFmSessionKey, lastFmSessionKey) ||
                other.lastFmSessionKey == lastFmSessionKey) &&
            (identical(other.lastFmUsername, lastFmUsername) ||
                other.lastFmUsername == lastFmUsername) &&
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
      normalizeVolume,
      crossfadeMs,
      scrobbleToLastFm,
      lastFmSessionKey,
      lastFmUsername,
      createdAt,
      updatedAt,
      userId);

  @override
  String toString() {
    return 'UserSettings(id: $id, normalizeVolume: $normalizeVolume, crossfadeMs: $crossfadeMs, scrobbleToLastFm: $scrobbleToLastFm, lastFmSessionKey: $lastFmSessionKey, lastFmUsername: $lastFmUsername, createdAt: $createdAt, updatedAt: $updatedAt, userId: $userId)';
  }
}

/// @nodoc
abstract mixin class _$UserSettingsCopyWith<$Res>
    implements $UserSettingsCopyWith<$Res> {
  factory _$UserSettingsCopyWith(
          _UserSettings value, $Res Function(_UserSettings) _then) =
      __$UserSettingsCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'normalize_volume') bool normalizeVolume,
      @JsonKey(name: 'crossfade_ms') int crossfadeMs,
      @JsonKey(name: 'scrobble_to_lastfm') bool scrobbleToLastFm,
      @JsonKey(name: 'lastfm_session_key') String? lastFmSessionKey,
      @JsonKey(name: 'lastfm_username') String? lastFmUsername,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'updated_at') DateTime updatedAt,
      @JsonKey(name: 'user_id') String userId});
}

/// @nodoc
class __$UserSettingsCopyWithImpl<$Res>
    implements _$UserSettingsCopyWith<$Res> {
  __$UserSettingsCopyWithImpl(this._self, this._then);

  final _UserSettings _self;
  final $Res Function(_UserSettings) _then;

  /// Create a copy of UserSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? normalizeVolume = null,
    Object? crossfadeMs = null,
    Object? scrobbleToLastFm = null,
    Object? lastFmSessionKey = freezed,
    Object? lastFmUsername = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? userId = null,
  }) {
    return _then(_UserSettings(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      normalizeVolume: null == normalizeVolume
          ? _self.normalizeVolume
          : normalizeVolume // ignore: cast_nullable_to_non_nullable
              as bool,
      crossfadeMs: null == crossfadeMs
          ? _self.crossfadeMs
          : crossfadeMs // ignore: cast_nullable_to_non_nullable
              as int,
      scrobbleToLastFm: null == scrobbleToLastFm
          ? _self.scrobbleToLastFm
          : scrobbleToLastFm // ignore: cast_nullable_to_non_nullable
              as bool,
      lastFmSessionKey: freezed == lastFmSessionKey
          ? _self.lastFmSessionKey
          : lastFmSessionKey // ignore: cast_nullable_to_non_nullable
              as String?,
      lastFmUsername: freezed == lastFmUsername
          ? _self.lastFmUsername
          : lastFmUsername // ignore: cast_nullable_to_non_nullable
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
