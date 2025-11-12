// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlaylistItem _$PlaylistItemFromJson(Map<String, dynamic> json) =>
    _PlaylistItem(
      id: json['id'] as String,
      playlistId: json['playlist_id'] as String,
      trackId: json['track_id'] as String,
      position: (json['position'] as num).toInt(),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      userId: json['user_id'] as String,
    );

Map<String, dynamic> _$PlaylistItemToJson(_PlaylistItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'playlist_id': instance.playlistId,
      'track_id': instance.trackId,
      'position': instance.position,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'user_id': instance.userId,
    };
