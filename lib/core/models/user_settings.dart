import 'package:freezed_annotation/freezed_annotation.dart';

// ignore_for_file: invalid_annotation_target

part 'user_settings.freezed.dart';
part 'user_settings.g.dart';

@freezed
abstract class UserSettings with _$UserSettings {
  const factory UserSettings({
    required String id,
    @JsonKey(name: 'normalize_volume') required bool normalizeVolume,
    @JsonKey(name: 'crossfade_ms') required int crossfadeMs,
    @Default(false)
    @JsonKey(name: 'scrobble_to_lastfm')
    bool scrobbleToLastFm,
    @JsonKey(name: 'lastfm_session_key') String? lastFmSessionKey,
    @JsonKey(name: 'lastfm_username') String? lastFmUsername,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
    @JsonKey(name: 'user_id') required String userId,
  }) = _UserSettings;

  factory UserSettings.fromJson(Map<String, dynamic> json) => _$UserSettingsFromJson(json);
}
