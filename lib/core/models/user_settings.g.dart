// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserSettings _$UserSettingsFromJson(Map<String, dynamic> json) =>
    _UserSettings(
      id: json['id'] as String,
      normalizeVolume: json['normalize_volume'] as bool,
      crossfadeMs: (json['crossfade_ms'] as num).toInt(),
      scrobbleToLastFm: json['scrobble_to_lastfm'] as bool? ?? false,
      lastFmSessionKey: json['lastfm_session_key'] as String?,
      lastFmUsername: json['lastfm_username'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      userId: json['user_id'] as String,
    );

Map<String, dynamic> _$UserSettingsToJson(_UserSettings instance) =>
    <String, dynamic>{
      'id': instance.id,
      'normalize_volume': instance.normalizeVolume,
      'crossfade_ms': instance.crossfadeMs,
      'scrobble_to_lastfm': instance.scrobbleToLastFm,
      'lastfm_session_key': instance.lastFmSessionKey,
      'lastfm_username': instance.lastFmUsername,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'user_id': instance.userId,
    };
