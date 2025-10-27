// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlaylistItemImpl _$$PlaylistItemImplFromJson(Map<String, dynamic> json) =>
    _$PlaylistItemImpl(
      id: json['id'] as String,
      playlistId: json['playlistId'] as String,
      trackId: json['trackId'] as String,
      position: (json['position'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      userId: json['userId'] as String,
    );

Map<String, dynamic> _$$PlaylistItemImplToJson(_$PlaylistItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'playlistId': instance.playlistId,
      'trackId': instance.trackId,
      'position': instance.position,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'userId': instance.userId,
    };
