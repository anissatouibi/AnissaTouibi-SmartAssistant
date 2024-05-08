import 'dart:math';

import 'package:smart_assistant_app/core/extensions/context_extensions.dart';
import 'package:smart_assistant_app/presentation/common/constants/assets_constants.dart';
import 'package:smart_assistant_app/presentation/common/theme/app_colors.dart';
import 'package:smart_assistant_app/presentation/common/widgets/images/auc_svg_image.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainBackButton extends StatelessWidget {
  const MainBackButton({super.key, this.backBtnBgColor});
  final Color? backBtnBgColor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.router.pop(),
      child: Center(
        child: ClipOval(
          child: Container(
            color: backBtnBgColor ?? AppColors.blackColor,
            height: 33.w,
            width: 33.w,
            child: Center(
              child: Transform.rotate(
                angle: !context.isArabic ? pi : 0,
                child: MainSvgImage(
                  //path:  context.isArabic ? MainAssetConstantsSvgs.pushedScreensBackBtnIcon : MainAssetConstantsSvgs.pushedScreensBackBtnIconEn,
                  path: "MainAssetConstantsSvgs.pushedScreensBackBtnIcon",
                  height: 15.h,
                  width: 10.w,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
