import 'package:smart_assistant_app/infrastructure/models/general/mainStatus.dart';
import 'package:smart_assistant_app/injection.dart';
import 'package:smart_assistant_app/presentation/common/cubit/auth/auth_cubit.dart';
import 'package:smart_assistant_app/presentation/common/routes/router.dart';
import 'package:smart_assistant_app/presentation/common/utils/bottomSheet/BottomSheetHelper.dart';
import 'package:smart_assistant_app/presentation/features/internet_connectivity_checker/cubit/internet_connectivity_cubit.dart';
import 'package:smart_assistant_app/presentation/features/public/cubit/public_data_cubit.dart';
import 'package:smart_assistant_app/presentation/features/splash_page/cubit/mobile_app_settings_cubit.dart';
import 'package:smart_assistant_app/presentation/features/splash_page/contents/auc_splash_content.dart';
import 'package:smart_assistant_app/presentation/features/user_portal/cubit/profile/cubit/user_profile_cubit.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const _splashAnimationDuration = Duration(seconds: 4);

enum NotificationType {
  noInternet,
  serverMaintenance,
  appUpdate,
}

@RoutePage()
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MobileAppSettingsCubit>(),
      child: const SplashContent(),
    );
  }
}

class SplashContent extends StatefulWidget {
  const SplashContent({super.key});

  @override
  State<SplashContent> createState() => _SplashContentState();
}

class _SplashContentState extends State<SplashContent> {
  bool splashFlag = false;
  bool appSettingsPassFlag = false;
  bool internetConnectedFlag = false;
  bool authenticating = false;
  bool homeDataFlag = false;
  bool profileFlag = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(_splashAnimationDuration, () {
      splashFlag = true;
      _goToRoute();
    });
  }

  _goToRoute() {
    // log("splashFlag = $splashFlag | internetConnectedFlag = $internetConnectedFlag | appSettingsPassFlag = $appSettingsPassFlag | authenticating = $authenticating | profileFlag = $profileFlag | homeDataFlag = $homeDataFlag | ");

    if (splashFlag
        //  &&
        //     internetConnectedFlag &&
        //     appSettingsPassFlag &&
        //     !authenticating &&
        //     profileFlag &&
        //     homeDataFlag
        ) {
      context.router.replace(const CommonWidgetsRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<InternetConnectivityCubit, InternetConnectivityState>(
          listener: (context, state) {
            if (state is Connected) {
              setState(() {
                internetConnectedFlag = true;
              });
              context.read<MobileAppSettingsCubit>().ckeckAppSettings();
            } else if (state is DisConnected) {
              setState(() {
                internetConnectedFlag = false;
              });
              BottomSheetHelper.showAppStartupNotificationSheet(
                  context: context, notification: NotificationType.noInternet);
            }
          },
        ),
        BlocListener<MobileAppSettingsCubit, MobileAppSettingsState>(
          listener: (context, state) {
            if (state is AppMaintenance) {
              setState(() {
                appSettingsPassFlag = false;
              });
              BottomSheetHelper.showAppStartupNotificationSheet(
                  context: context, notification: NotificationType.serverMaintenance);
            } else if (state is AppUpdate) {
              setState(() {
                appSettingsPassFlag = false;
              });
              BottomSheetHelper.showAppStartupNotificationSheet(
                  context: context, notification: NotificationType.appUpdate);
            } else if (state is AppSettingsReady) {
              setState(() {
                appSettingsPassFlag = true;
              });
              // auth check
              context.read<AuthCubit>().requestAuthCheck();

              // initial fetches independent of AuthState
              context.read<PublicDataCubit>().getInitialPublicFetches();
            }
          },
        ),
        BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is Authenticated) {
              setState(() {
                authenticating = false;
              });

              // fetch current profile
              context.read<UserProfileCubit>().getAccountCurrentProfile();
            } else if (state is Unauthenticated) {
              setState(() {
                authenticating = false;
                profileFlag = true;
              });
            } else if (state is Checking) {
              setState(() {
                authenticating = true;
              });
            }
            _goToRoute();
          },
        ),
        BlocListener<UserProfileCubit, UserProfileState>(
          listener: (context, state) {
            if (state.mainStatus == MainStatus.loaded) {
              setState(() {
                profileFlag = true;
              });
              // fetch account relavent profiles
            } else if (state.mainStatus == MainStatus.failure) {
              context.read<AuthCubit>().logOut();
            }
            _goToRoute();
          },
        ),
      ],
      child: const MainSplashContent(),
    );
  }
}
