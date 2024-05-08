import 'package:smart_assistant_app/presentation/common/theme/app_colors.dart';
import 'package:smart_assistant_app/presentation/common/theme/app_text_styles.dart';
import 'package:smart_assistant_app/presentation/common/widgets/buttons/auc_text_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // bg gradient shadow
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [
                0.0,
                1.0,
              ],
              colors: [
                AppColors.primaryBlackishColor.withOpacity(0.25),
                AppColors.primaryBlackishColor,
              ],
            )),
          ),
          //Content
          Positioned(
            left: 32.w,
            right: 32.w,
            top: 155.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [
                Stack(
                  children: [
                    Positioned(
                      left: 28.w,
                      bottom: 31.h,
                      child: Text(
                        "Your guide to a healthier lifestyle",
                        style: AppTextStyles.px15wLight(context).toPrimaryWhiteColor,
                      ),
                    ),
                  ],
                ),
                MainTextButton(
                  onPressed: () {},
                  text: "LOGIN",
                  type: MainBottonType.red85Borderless,
                ),
                SizedBox(height: 13.h),
                MainTextButton(
                  onPressed: () {},
                  text: "REGISTER",
                  type: MainBottonType.whiteBorderTransparent,
                ),
                SizedBox(height: 9.h),
                InkWell(
                  child: Center(
                    child: Text(
                      "Terms & Conditions",
                      style: AppTextStyles.px12wRegular(context)
                          .copyWith(decoration: TextDecoration.underline)
                          .toPrimaryWhiteColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 41.h,
            left: 0,
            right: 0,
            child: Column(children: [
              Text('Powered By', style: AppTextStyles.px12wRegular(context).toPrimaryWhiteColor),
              SizedBox(height: 6.h),
            ]),
          )
        ],
      ),
    );
  }
}
