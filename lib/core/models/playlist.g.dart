// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Playlist _$PlaylistFromJson(Map<String, dynamic> json) => _Playlist(
      id: json['id'] as String,
      name: json['name'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      userId: json['user_id'] as String,
    );

Map<String, dynamic> _$PlaylistToJson(_Playlist instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'user_id': instance.userId,
    };
