import 'dart:io';

import 'package:smart_assistant_app/i18n/strings.g.dart';
import 'package:smart_assistant_app/presentation/common/constants/assets_constants.dart';
import 'package:smart_assistant_app/presentation/common/theme/app_text_styles.dart';
import 'package:smart_assistant_app/presentation/common/widgets/buttons/auc_text_button.dart';
import 'package:smart_assistant_app/presentation/features/internet_connectivity_checker/cubit/internet_connectivity_cubit.dart';
import 'package:smart_assistant_app/presentation/features/splash_page/splash_page.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class AppStartupNotificationSheetContent extends StatefulWidget {
  const AppStartupNotificationSheetContent({super.key, required this.notification});
  final NotificationType notification;

  @override
  State<AppStartupNotificationSheetContent> createState() =>
      _AppStartupNotificationSheetContentState();
}

class _AppStartupNotificationSheetContentState extends State<AppStartupNotificationSheetContent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 10.h),
          Flexible(
            child: SizedBox(
              height: 175.h,
              width: widget.notification == NotificationType.appUpdate ? 120.w : 150.w,
              child: FlareActor(
                getAnimationPathFromNotification(widget.notification),
                alignment: Alignment.center,
                fit: BoxFit.contain,
                animation: getAnimationTrigger(widget.notification),
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Text(
              getMsgFromNotification(widget.notification, context),
              style: AppTextStyles.px12wRegular(context),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(height: 35.h),
          Row(
            children: [
              Expanded(
                child: MainTextButton(
                  onPressed: () async {
                    if (widget.notification == NotificationType.appUpdate) {
                      _launchAppStores();
                    } else {
                      final internetCubit = context.read<InternetConnectivityCubit>();
                      Navigator.pop(context);
                      await Future.delayed(const Duration(seconds: 1));
                      internetCubit.oneTimeChecker(); // reTrigger splash logic
                    }
                  },
                  text: getPositiveBtnLabelFromNotification(widget.notification, context),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: MainTextButton(
                  onPressed: () {
                    exit(0);
                  },
                  text: context.t.common.close,
                ),
              ),
            ],
          ),
          SizedBox(height: 28.h),
        ],
      ),
    );
  }

  String getPositiveBtnLabelFromNotification(NotificationType notification, BuildContext context) {
    switch (notification) {
      case NotificationType.serverMaintenance:
        return context.t.common.tryAgain;

      case NotificationType.noInternet:
        return t.common.tryAgain;

      case NotificationType.appUpdate:
        return t.common.update;
    }
  }

  String getMsgFromNotification(NotificationType notification, BuildContext context) {
    switch (notification) {
      case NotificationType.serverMaintenance:
        return context.t.errors.failures.maintenance;

      case NotificationType.noInternet:
        return t.errors.failures.no_internet;

      case NotificationType.appUpdate:
        return t.errors.failures.update_app;
    }
  }

  String getAnimationPathFromNotification(NotificationType notification) {
    switch (notification) {
      case NotificationType.serverMaintenance:
        return MainAssetConstantsAnimations.appMaintenanceAnimation;

      case NotificationType.noInternet:
        return MainAssetConstantsAnimations.noInternetAnimation;

      case NotificationType.appUpdate:
        return MainAssetConstantsAnimations.appUpdateAnimation;
    }
  }
}

String getAnimationTrigger(NotificationType notification) {
  switch (notification) {
    case NotificationType.serverMaintenance:
      return 'spin2';

    case NotificationType.noInternet:
      return 'start';

    case NotificationType.appUpdate:
      return 'animate';
  }
}

void _launchAppStores() {
  if (Platform.isAndroid || Platform.isIOS) {
    final url = Uri.parse(
      Platform.isAndroid
          ? "https://play.google.com/store/apps/details?id="
          : "https://apps.apple.com/qa/app/",
    );
    launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    );
  }
}
