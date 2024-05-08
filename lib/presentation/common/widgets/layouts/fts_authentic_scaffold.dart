import 'package:smart_assistant_app/i18n/strings.g.dart';
import 'package:smart_assistant_app/presentation/common/constants/assets_constants.dart';
import 'package:smart_assistant_app/presentation/common/theme/app_colors.dart';
import 'package:smart_assistant_app/presentation/common/theme/app_text_styles.dart';
import 'package:smart_assistant_app/presentation/common/widgets/images/auc_svg_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainAuthenticScaffold extends StatelessWidget {
  const MainAuthenticScaffold({
    super.key,
    required this.child,
    this.resizeToAvoidBottomInset = true,
    this.unfocusOnTapOut = true,
    this.bgColor = AppColors.backgroundLightPurple,
    this.withShadow = false,
  });
  final Widget child;

  final bool resizeToAvoidBottomInset;
  final bool unfocusOnTapOut;
  final Color bgColor;
  final bool withShadow;
  @override
  Widget build(BuildContext context) {
    return Listener(
      /// unfocus when tapped outside
      behavior: HitTestBehavior.opaque,
      onPointerDown: (_) => unfocusOnTapOut ? FocusManager.instance.primaryFocus?.unfocus() : null,
      child: Scaffold(
          backgroundColor: bgColor,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          body: Column(children: [
            Expanded(child: child),
          ])),
    );
  }
}
