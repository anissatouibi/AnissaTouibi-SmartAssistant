import 'package:smart_assistant_app/core/extensions/string_extensions.dart';
import 'package:smart_assistant_app/infrastructure/models/account/user_profile.dart';
import 'package:smart_assistant_app/presentation/common/theme/app_colors.dart';
import 'package:smart_assistant_app/presentation/common/theme/app_text_styles.dart';
import 'package:smart_assistant_app/presentation/common/widgets/clippers/auc_diagonal_clipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserAvatarPickerWidget extends StatelessWidget {
  const UserAvatarPickerWidget({super.key, required this.profile});

  final UserProfile profile;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 39.h),
            MainDiagonalCLipper(
              child: Container(
                decoration: const BoxDecoration(color: AppColors.whiteColor),
                child: Column(children: [
                  SizedBox(height: 112.h),
                ]),
              ),
            ),
          ],
        ),
        Center(
          child: ClipOval(
            child: Container(
              height: 151.h,
              width: 151.h,
              color: AppColors.whiteColor,
              child: ClipOval(
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.ramliColor,
                  ),
                  margin: EdgeInsets.all(10.sp),
                  height: 45.h,
                  width: 45.h,
                  child: Center(
                    child: Text(
                      profile.name.firstLetterCap,
                      style: AppTextStyles.px28wBold(context)
                          .copyWith(fontSize: 53.sp, fontWeight: FontWeight.w800)
                          .toRamliColor
                          .toEnglishFont,
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
