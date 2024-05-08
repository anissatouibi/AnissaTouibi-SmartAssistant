import 'package:smart_assistant_app/presentation/common/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shimmer/shimmer.dart';

class AucShimmer extends StatelessWidget {
  const AucShimmer({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    // final int i = Random().nextInt(4);

    return Shimmer.fromColors(
        baseColor: AppColors.ramliColor,
        highlightColor: AppColors.primaryRed8AColor,
        direction: ShimmerDirection.rtl,
        period: 300.ms,
        child: child);
  }
}

_getShimmerDirection(int i) {
  switch (i) {
    case 0:
      return ShimmerDirection.btt;
    case 1:
      return ShimmerDirection.ltr;
    case 2:
      return ShimmerDirection.rtl;
    case 3:
      return ShimmerDirection.ttb;
  }
}
