import 'package:smart_assistant_app/presentation/common/theme/app_colors.dart';
import 'package:smart_assistant_app/presentation/common/widgets/bottom_sheet/btm_sheet_content_edge_shadow_wrapper.dart';
import 'package:smart_assistant_app/presentation/common/widgets/bottom_sheet/confirmation_sheet_content.dart';
import 'package:smart_assistant_app/presentation/common/widgets/bottom_sheet/operation_status_sheet.dart';
import 'package:smart_assistant_app/presentation/features/splash_page/bottom_sheet/startup_notification_sheet_content.dart';
import 'package:smart_assistant_app/presentation/features/splash_page/splash_page.dart';
import 'package:flutter/material.dart';

enum SheetStatusType { success, failure }

class BottomSheetHelper {
  BottomSheetHelper();
  static showConfirmationSheet({
    required BuildContext context,
    required String text,
    String? confirmationTitle,
    TextStyle? confirmationTitleTextStyle,
    required Function onConfirmCallback,
  }) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        barrierColor: AppColors.primaryRed8AColor.withOpacity(0.1),
        isDismissible: false,
        enableDrag: true,
        context: context,
        builder: (contextt) => BottomSheetContentEdgeShadowWrapper(
                child: ConfirmationSheetContent(
              onConfirmCallback: onConfirmCallback,
              text: text,
              confirmationTitle: confirmationTitle,
              confirmationTitleTextStyle: confirmationTitleTextStyle,
            )));
  }

  static showWidgetBottomSheet({
    required BuildContext context,
    required Widget content,
    bool isDismissible = true,
    bool enableDrag = true,
    bool textFieldKeepFocus = true,
  }) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isDismissible: isDismissible,
        enableDrag: enableDrag,
        isScrollControlled: true,
        barrierColor: AppColors.primaryRed8AColor.withOpacity(0.1),
        context: context,
        builder: (contextt) {
          if (!textFieldKeepFocus) {
            return Listener(
              /// unfocus when tapped outside
              behavior: HitTestBehavior.opaque,
              onPointerDown: (_) => FocusManager.instance.primaryFocus?.unfocus(),
              child: BottomSheetContentEdgeShadowWrapper(
                child: content,
              ),
            );
          }
          return BottomSheetContentEdgeShadowWrapper(
            child: content,
          );
        });
  }

  static showAppStartupNotificationSheet(
      {required BuildContext context, required NotificationType notification}) {
    showModalBottomSheet(
        backgroundColor: AppColors.whiteColor,
        isDismissible: false,
        enableDrag: false,
        shape: const RoundedRectangleBorder(
          borderRadius:
              BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        ),
        context: context,
        builder: (contextt) => AppStartupNotificationSheetContent(
              notification: notification,
            ));
  }

  static showStatusSheet({
    required String text,
    required BuildContext context,
    required SheetStatusType statusType,
    TextStyle? textStyle,
    bool overlayDelayed = true,
  }) async {
    if (overlayDelayed) {
      await Future.delayed(const Duration(milliseconds: 500));
    }
    // ignore: use_build_context_synchronously
    showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: true,
        shape: const RoundedRectangleBorder(
          borderRadius:
              BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        ),
        context: context,
        builder: (context) => OperationStatusSheetContent(
              text: text,
              statusType: statusType,
              textStyle: textStyle,
            ));
  }
}
