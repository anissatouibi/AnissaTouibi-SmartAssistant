import 'package:freezed_annotation/freezed_annotation.dart';
part 'app_settings.freezed.dart';
part 'app_settings.g.dart';

@freezed
class AppSettings with _$AppSettings {
  const factory AppSettings({
    @Default(0) @JsonKey(name: "IosAppVersion") int iosAppVersionIos,
    @Default(0) @JsonKey(name: "AndroidAppVersion") int androidAppVersion,
    required bool maintenance,
    @Default(0) int currentAndroidPatch,
    @Default(0) int currentIosPatch,
  }) = _AppSettings;
  factory AppSettings.fromJson(Map<String, dynamic> json) => _$AppSettingsFromJson(json);
}
