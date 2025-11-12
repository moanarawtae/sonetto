// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Track _$TrackFromJson(Map<String, dynamic> json) => _Track(
      id: json['id'] as String,
      title: json['title'] as String,
      artist: json['artist'] as String,
      album: json['album'] as String,
      durationMs: (json['duration_ms'] as num).toInt(),
      sourceUrl: json['source_url'] as String,
      artworkUrl: json['artwork_url'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      userId: json['user_id'] as String,
    );

Map<String, dynamic> _$TrackToJson(_Track instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'artist': instance.artist,
      'album': instance.album,
      'duration_ms': instance.durationMs,
      'source_url': instance.sourceUrl,
      'artwork_url': instance.artworkUrl,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'user_id': instance.userId,
    };
