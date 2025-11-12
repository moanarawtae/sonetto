import 'package:freezed_annotation/freezed_annotation.dart';

// ignore_for_file: invalid_annotation_target

part 'track.freezed.dart';
part 'track.g.dart';

@freezed
abstract class Track with _$Track {
  const factory Track({
    required String id,
    required String title,
    required String artist,
    required String album,
    @JsonKey(name: 'duration_ms') required int durationMs,
    @JsonKey(name: 'source_url') required String sourceUrl,
    @JsonKey(name: 'artwork_url') String? artworkUrl,
    @JsonKey(includeFromJson: false, includeToJson: false) String? localPath,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
    @JsonKey(name: 'user_id') required String userId,
  }) = _Track;

  factory Track.fromJson(Map<String, dynamic> json) => _$TrackFromJson(json);
}
