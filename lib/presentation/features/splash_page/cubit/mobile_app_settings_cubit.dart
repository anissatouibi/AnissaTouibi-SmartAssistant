import 'dart:io';

import 'package:smart_assistant_app/core/app.dart';
import 'package:smart_assistant_app/core/usecases/common/uc_get_app_settings.dart';
import 'package:smart_assistant_app/core/usecases/usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
part 'mobile_app_settings_state.dart';
part 'mobile_app_settings_cubit.freezed.dart';

@injectable
class MobileAppSettingsCubit extends Cubit<MobileAppSettingsState> {
  final GetAppSettings getAppSettings;
  MobileAppSettingsCubit(this.getAppSettings) : super(const Initial());

  Future<void> ckeckAppSettings() async {
    emit(const Initial());

    final either = await getAppSettings(NoParams());
    either.fold((l) {
      emit(const AppMaintenance());
    }, (appSettings) {
      if (appSettings.maintenance) {
        emit(const AppMaintenance());
      } else if (AppEnvState.currentBackendVersion <
          (Platform.isAndroid ? appSettings.androidAppVersion : appSettings.iosAppVersionIos)) {
        //mb add force update for updates(not patches) when needed=> force_update true = has to download latest store release/fu false : store release can be published but auto downloaded not forcefully, case example: the patch has already done the work and the store release is just to optimize the UX for new users
        emit(const AppUpdate());
      } else {
        emit(const AppSettingsReady());
      }
    });
  }
}
