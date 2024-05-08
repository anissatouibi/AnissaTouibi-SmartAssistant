import 'package:smart_assistant_app/core/extensions/context_extensions.dart';
import 'package:smart_assistant_app/presentation/common/theme/app_colors.dart';
import 'package:smart_assistant_app/presentation/common/theme/app_text_styles.dart';
import 'package:smart_assistant_app/presentation/common/utils/general_utils.dart';
import 'package:smart_assistant_app/presentation/common/widgets/clippers/auc_diagonal_clipper.dart';
import 'package:smart_assistant_app/presentation/common/widgets/images/auc_svg_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BNavBarItem extends StatelessWidget {
  final String unselectedPic;
  final String selectedPic;
  final bool selected;
  final String label;

  const BNavBarItem({
    super.key,
    required this.unselectedPic,
    required this.selectedPic,
    required this.selected,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.h,
      child: Padding(
        padding: EdgeInsets.only(top: 19.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MainSvgImage(
              path: selected ? selectedPic : unselectedPic,
              height: 24.h,
              width: 24.h,
            ),
            SizedBox(height: 6.h),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: AppTextStyles.px10wMedium(context).copyWith(
                  color: selected ? AppColors.primaryRed8AColor : const Color(0xff797A7B),
                  letterSpacing: !context.isArabic ? 0.0 : null),
            ),
          ],
        ),
      ),
    );
  }
}

class BNavBarItemSelected extends StatelessWidget {
  final String unselectedPic;
  final String selectedPic;
  final String label;

  const BNavBarItemSelected({
    super.key,
    required this.unselectedPic,
    required this.selectedPic,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipOval(
            child: Container(
              height: 48.h,
              width: 48.h,
              color: AppColors.primaryRed8AColor,
              child: Center(
                child: MainSvgImage(
                  path: selectedPic,
                  height: 24.h,
                  width: 24.h,
                ),
              ),
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style:
                AppTextStyles.px10wSemiBold(context).copyWith(color: AppColors.primaryRed8AColor),
          ),
          SizedBox(height: 4.h),
        ],
      ),
    );
  }
}
