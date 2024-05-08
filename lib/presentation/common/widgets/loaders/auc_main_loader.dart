import 'package:smart_assistant_app/presentation/common/constants/assets_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class MainHammerLoader extends StatelessWidget {
  final double? size;
  const MainHammerLoader({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 30.w),
      child: Center(
        child: Lottie.asset(MainAssetConstantsAnimations.hammerLoader,
            height: size ?? 350.h,
            width: size ?? 350.h,
            fit: BoxFit.cover,
            alignment: Alignment.topCenter),
      ),
    );
  }
}
