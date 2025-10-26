import 'package:freezed_annotation/freezed_annotation.dart';

part 'playlist_item.freezed.dart';
part 'playlist_item.g.dart';

@freezed
class PlaylistItem with _$PlaylistItem {
  const factory PlaylistItem({
    required String id,
    required String playlistId,
    required String trackId,
    required int position,
    required DateTime createdAt,
    required DateTime updatedAt,
    required String userId,
  }) = _PlaylistItem;

  factory PlaylistItem.fromJson(Map<String, dynamic> json) => _$PlaylistItemFromJson(json);
}
