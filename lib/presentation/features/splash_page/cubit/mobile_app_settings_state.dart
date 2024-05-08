part of 'mobile_app_settings_cubit.dart';

@freezed
class MobileAppSettingsState with _$MobileAppSettingsState {
  const factory MobileAppSettingsState.initial() = Initial;
  const factory MobileAppSettingsState.appMaintenance() = AppMaintenance;
  const factory MobileAppSettingsState.appUpdate() = AppUpdate;
  const factory MobileAppSettingsState.appSettingsReady() = AppSettingsReady;
}
