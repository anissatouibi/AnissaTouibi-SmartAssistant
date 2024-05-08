import 'package:smart_assistant_app/presentation/common/constants/assets_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class RedDotLocalLoader extends StatelessWidget {
  final double? size;
  const RedDotLocalLoader({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        MainAssetConstantsAnimations.redDotLoaderAnimation,
        width: size ?? 100.h,
        height: size ?? 100.h,
        fit: BoxFit.fill,
      ),
    );
  }
}
