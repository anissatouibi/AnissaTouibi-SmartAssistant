import 'package:auto_route/auto_route.dart';
import 'package:smart_assistant_app/core/extensions/context_extensions.dart';
import 'package:smart_assistant_app/presentation/common/constants/assets_constants.dart';
import 'package:smart_assistant_app/presentation/common/routes/router.dart';
import 'package:smart_assistant_app/presentation/common/theme/app_colors.dart';
import 'package:smart_assistant_app/presentation/common/theme/app_text_styles.dart';
import 'package:smart_assistant_app/presentation/common/widgets/images/auc_asset_image.dart';
import 'package:smart_assistant_app/presentation/common/widgets/images/auc_svg_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainSplashContent extends StatelessWidget {
  const MainSplashContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff852735),
      body: Stack(
        fit: StackFit.expand,
        children: [
          //Texture
          Positioned(
            width: context.width,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [],
            ),
          ).animate().fadeIn().slideY(
              begin: 0, end: -0.5, duration: 2.seconds, delay: 600.ms, curve: Curves.decelerate),
        ],
      ),
    );
  }
}
