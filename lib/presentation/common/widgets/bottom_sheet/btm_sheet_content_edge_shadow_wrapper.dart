import 'package:smart_assistant_app/presentation/common/theme/app_colors.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomSheetContentEdgeShadowWrapper extends StatelessWidget {
  const BottomSheetContentEdgeShadowWrapper({
    super.key,
    required this.child,
  });
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Stack(children: [
          GestureDetector(
            onTap: () => context.router.pop(),
            child: Container(
              height: 150.h,
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [
                  0.0,
                  1.0,
                ],
                colors: [
                  AppColors.primaryRed8AColor.withOpacity(0),
                  AppColors.primaryRed8AColor,
                ],
              )),
            ),
          ),
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 50.h),
                ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: Container(color: Colors.white, child: child))
              ])
        ])
      ]),
    );
  }
}
