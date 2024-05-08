import 'package:smart_assistant_app/presentation/common/theme/app_buttons_theme.dart';
import 'package:smart_assistant_app/presentation/common/theme/app_colors.dart';
import 'package:smart_assistant_app/presentation/common/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum MainBottonType {
  redBorderless,
  red85Borderless,
  whiteBorderless,
  whiteWithRedBorder,
  blackBorderTransparent,
  whiteBorderTransparent,
  pqTransparentWithBlueBorder,
  pqBlueBorderless,
}

class MainTextButton extends StatelessWidget {
  final Function onPressed;
  final double? width;
  final double? height;
  final String? text;
  final TextStyle? textStyle;
  final MainBottonType type;
  final Widget? child;
  const MainTextButton({
    super.key,
    required this.onPressed,
    this.width,
    this.height,
    required this.text,
    this.textStyle,
    this.type = MainBottonType.redBorderless,
    this.child,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height ?? 48.h,
      child: TextButton(
        style: AppButtonsTheme.getMainMainTextButtonTheme(type: type),
        onPressed: () => onPressed(),
        child: Center(
          child: child ??
              Text(
                text!,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.px16wMedium(context).copyWith(
                    color: type == MainBottonType.redBorderless ||
                            type == MainBottonType.red85Borderless ||
                            type == MainBottonType.whiteBorderTransparent
                        ? AppColors.whiteColor
                        : type == MainBottonType.whiteBorderless ||
                                type == MainBottonType.whiteWithRedBorder
                            ? AppColors.primaryRed8AColor
                            : type == MainBottonType.pqTransparentWithBlueBorder
                                ? AppColors.blueLight41Color
                                : AppColors.blackColor),
              ),
        ),
      ),
    );
  }
}
