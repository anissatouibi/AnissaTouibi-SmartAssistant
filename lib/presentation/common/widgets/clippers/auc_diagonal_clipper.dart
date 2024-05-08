import 'package:smart_assistant_app/presentation/common/utils/general_utils.dart';
import 'package:flutter/material.dart';

class MainDiagonalCLipper extends StatelessWidget {
  const MainDiagonalCLipper({super.key, this.inversed = false, this.radius, required this.child});
  final bool inversed;
  final double? radius;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: GeneralUtils.defaultBorderRadius(radius: radius),
      child: child,
    );
  }
}
