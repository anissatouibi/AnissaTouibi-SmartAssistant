import 'package:freezed_annotation/freezed_annotation.dart';
part 'profile_settings.freezed.dart';
part 'profile_settings.g.dart';

@freezed
class ProfileSettings with _$ProfileSettings {
  const factory ProfileSettings({
    @JsonKey(name: "activate_all_notifications") required bool activateAllNotifs,
    @JsonKey(name: "activate_auction_notifications") required bool activateAuctionNotifs,
    @JsonKey(name: "activate_bookmark_notifications") required bool activateBookmarkNotifs,
  }) = _ProfileSettings;
  factory ProfileSettings.fromJson(Map<String, dynamic> json) => _$ProfileSettingsFromJson(json);
}
