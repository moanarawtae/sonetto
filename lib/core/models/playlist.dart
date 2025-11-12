import 'package:freezed_annotation/freezed_annotation.dart';

// ignore_for_file: invalid_annotation_target

part 'playlist.freezed.dart';
part 'playlist.g.dart';

@freezed
abstract class Playlist with _$Playlist {
  const factory Playlist({
    required String id,
    required String name,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
    @JsonKey(name: 'user_id') required String userId,
  }) = _Playlist;

  factory Playlist.fromJson(Map<String, dynamic> json) => _$PlaylistFromJson(json);
}
