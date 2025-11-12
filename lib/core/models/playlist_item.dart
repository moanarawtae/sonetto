import 'package:freezed_annotation/freezed_annotation.dart';

// ignore_for_file: invalid_annotation_target

part 'playlist_item.freezed.dart';
part 'playlist_item.g.dart';

@freezed
abstract class PlaylistItem with _$PlaylistItem {
  const factory PlaylistItem({
    required String id,
    @JsonKey(name: 'playlist_id') required String playlistId,
    @JsonKey(name: 'track_id') required String trackId,
    required int position,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
    @JsonKey(name: 'user_id') required String userId,
  }) = _PlaylistItem;

  factory PlaylistItem.fromJson(Map<String, dynamic> json) => _$PlaylistItemFromJson(json);
}
