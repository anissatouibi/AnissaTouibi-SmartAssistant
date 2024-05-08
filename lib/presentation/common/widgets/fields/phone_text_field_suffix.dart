import 'package:smart_assistant_app/core/app.dart';
import 'package:smart_assistant_app/presentation/common/constants/general_constants.dart';
import 'package:smart_assistant_app/presentation/common/theme/app_colors.dart';
import 'package:smart_assistant_app/presentation/common/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PhoneTextFieldSuffixWidget extends StatelessWidget {
  const PhoneTextFieldSuffixWidget({
    super.key,
    required this.isQatarPrefix,
  });
  final bool isQatarPrefix;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 22.h,
          width: 1.w,
          color: AppColors.primaryBlackishColor,
        ),
        SizedBox(width: 5.w),
        if (!AppEnvState.isProd)
          Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.primaryBlackishColor,
            size: 24.sp,
          ),
        SizedBox(
          width: 32.w,
          child: Center(
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Text(
                isQatarPrefix
                    ? GeneralConstants.qatarPhonePrefix
                    : GeneralConstants.tunisiaPhonePrefix,
                style: AppTextStyles.px12wRegular(context)
                    .copyWith(color: AppColors.primaryBlackishColor)
                    .toArabicFont,
              ),
            ),
          ),
        ),
        SizedBox(width: 6.w),
      ],
    );
  }
}
