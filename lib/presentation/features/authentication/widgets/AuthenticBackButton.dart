import 'dart:math';

import 'package:smart_assistant_app/core/extensions/context_extensions.dart';
import 'package:smart_assistant_app/presentation/common/constants/assets_constants.dart';
import 'package:smart_assistant_app/presentation/common/theme/app_colors.dart';
import 'package:smart_assistant_app/presentation/common/widgets/images/auc_svg_image.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthenticBackButton extends StatelessWidget {
  const AuthenticBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 5.h,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 28.w),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => context.router.pop(),
              child: ClipOval(
                child: Container(
                  color: AppColors.blackColor,
                  height: 33.w,
                  width: 33.w,
                  child: Center(
                    child: Transform.rotate(
                      angle: !context.isArabic ? pi : 0,
                      child: MainSvgImage(
                        path: "MainAssetConstantsSvgs.pushedScreensBackBtnIcon",
                        width: 7.w,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
