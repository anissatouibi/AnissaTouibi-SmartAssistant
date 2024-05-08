import 'package:smart_assistant_app/presentation/common/theme/app_colors.dart';
import 'package:smart_assistant_app/presentation/common/utils/general_utils.dart';
import 'package:smart_assistant_app/presentation/common/widgets/buttons/auc_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButtonsTheme {
  static final redBorderlessButtonStyle = ButtonStyle(
      // minimumSize: MaterialStateProperty.all<Size>(Size(double.infinity, 44.h)),
      overlayColor: MaterialStateProperty.all<Color>(AppColors.ramliColor.withOpacity(.25)),
      foregroundColor: MaterialStateProperty.all<Color>(AppColors.primaryRed8AColor),
      backgroundColor: MaterialStateProperty.all<Color>(AppColors.primaryRed8AColor),
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: GeneralUtils.defaultBorderRadius())));
  static final redBorderless85ButtonStyle = redBorderlessButtonStyle.copyWith(
    foregroundColor: MaterialStateProperty.all<Color>(AppColors.red85Color),
    backgroundColor: MaterialStateProperty.all<Color>(AppColors.red85Color),
  );
  static final whiteBorderlessButtonStyle = redBorderlessButtonStyle.copyWith(
    overlayColor: MaterialStateProperty.all<Color>(AppColors.greyLightEEEColor),
    foregroundColor: MaterialStateProperty.all<Color>(AppColors.whiteColor),
    backgroundColor: MaterialStateProperty.all<Color>(AppColors.whiteColor),
  );
  static final pqBlueBorderlessButtonStyle = redBorderlessButtonStyle.copyWith(
    overlayColor: MaterialStateProperty.all<Color>(AppColors.primaryRed8AColor.withOpacity(.05)),
    foregroundColor: MaterialStateProperty.all<Color>(AppColors.blueLight41Color),
    backgroundColor: MaterialStateProperty.all<Color>(AppColors.blueLight41Color),
  );
  static final whiteWithRedBorderButtonStyle = redBorderlessButtonStyle.copyWith(
    overlayColor: MaterialStateProperty.all<Color>(AppColors.greyLightEEEColor),
    foregroundColor: MaterialStateProperty.all<Color>(AppColors.whiteColor),
    backgroundColor: MaterialStateProperty.all<Color>(AppColors.whiteColor),
    side: MaterialStateProperty.all<BorderSide>(
        const BorderSide(width: 1, color: AppColors.primaryRed8AColor)),
  );
  static final blackBorderTransparentButtonStyle = redBorderlessButtonStyle.copyWith(
    overlayColor: MaterialStateProperty.all<Color>(AppColors.red85Color.withOpacity(.25)),
    foregroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
    backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
    side: MaterialStateProperty.all<BorderSide>(
        const BorderSide(width: 1, color: AppColors.blackColor)),
  );
  static final whiteBorderTransparentButtonStyle = blackBorderTransparentButtonStyle.copyWith(
    side: MaterialStateProperty.all<BorderSide>(
        const BorderSide(width: 1, color: AppColors.whiteColor)),
  );
  static final pqTransparentWithBlueBorderButtonStyle = blackBorderTransparentButtonStyle.copyWith(
    overlayColor: MaterialStateProperty.all<Color>(AppColors.primaryRed8AColor.withOpacity(.05)),
    side: MaterialStateProperty.all<BorderSide>(
        const BorderSide(width: 1, color: AppColors.blueLight41Color)),
  );
  static ButtonStyle getMainMainTextButtonTheme({
    required MainBottonType type,
  }) {
    switch (type) {
      case MainBottonType.redBorderless:
        return redBorderlessButtonStyle;
      case MainBottonType.red85Borderless:
        return redBorderless85ButtonStyle;
      case MainBottonType.whiteBorderless:
        return whiteBorderlessButtonStyle;
      case MainBottonType.whiteWithRedBorder:
        return whiteWithRedBorderButtonStyle;
      case MainBottonType.blackBorderTransparent:
        return blackBorderTransparentButtonStyle;
      case MainBottonType.whiteBorderTransparent:
        return whiteBorderTransparentButtonStyle;
      case MainBottonType.pqTransparentWithBlueBorder:
        return pqTransparentWithBlueBorderButtonStyle;
      case MainBottonType.pqBlueBorderless:
        return pqBlueBorderlessButtonStyle;
    }
  }
}
