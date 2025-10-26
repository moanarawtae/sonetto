import 'package:freezed_annotation/freezed_annotation.dart';

part 'track.freezed.dart';
part 'track.g.dart';

@freezed
class Track with _$Track {
  const factory Track({
    required String id,
    required String title,
    required String artist,
    required String album,
    required int durationMs,
    required String sourceUrl,
    String? artworkUrl,
    required DateTime createdAt,
    required DateTime updatedAt,
    required String userId,
  }) = _Track;

  factory Track.fromJson(Map<String, dynamic> json) => _$TrackFromJson(json);
}
