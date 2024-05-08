import 'package:smart_assistant_app/presentation/common/theme/app_colors.dart';
import 'package:smart_assistant_app/presentation/common/theme/app_text_styles.dart';
import 'package:smart_assistant_app/presentation/common/widgets/buttons/auc_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainPopSliverAppBar extends StatelessWidget {
  const MainPopSliverAppBar(
      {super.key,
      this.backgroundColor = AppColors.backgroundLightPurple,
      this.pinned = true,
      required this.title,
      this.backBtnBgColor});
  final Color? backgroundColor;
  final Color? backBtnBgColor;
  final bool pinned;
  final String title;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      // padding: EdgeInsets.symmetric(horizontal: 18.w),
      backgroundColor: backgroundColor,
      // elevation: 0,
      pinned: pinned,
      automaticallyImplyLeading: false,
      bottom: const PreferredSize(
        //needed
        preferredSize: Size.fromHeight(0.0),
        child: SizedBox.shrink(),
      ),
      flexibleSpace: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 29.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MainBackButton(backBtnBgColor: backBtnBgColor),
                  Text(
                    title,
                    style: AppTextStyles.px19wBold(context),
                  ),
                  SizedBox(
                    height: 33.w,
                    width: 33.w,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
