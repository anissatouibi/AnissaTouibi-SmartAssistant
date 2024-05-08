import 'dart:async';
import 'dart:ui';

import 'package:smart_assistant_app/core/extensions/context_extensions.dart';
import 'package:smart_assistant_app/presentation/common/widgets/buttons/auc_back_button.dart';
import 'package:smart_assistant_app/presentation/common/widgets/loaders/auc_main_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainLoadingOverlay extends StatefulWidget {
  const MainLoadingOverlay({super.key, required this.child, required this.active});
  final Widget child;
  final bool active;

  @override
  _MainLoadingOverlayState createState() => _MainLoadingOverlayState();
}

class _MainLoadingOverlayState extends State<MainLoadingOverlay> {
  bool _shouldShowOverlay = false;
  bool isActive = false;
  @override
  void initState() {
    super.initState();
    isActive = widget.active;
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.active) {
      setState(() {
        isActive = true;
      });
      Timer(Duration.zero, () {
        if (mounted) {
          setState(() {
            _shouldShowOverlay = true;
          });
        }
      });
    } else {
      setState(() {
        _shouldShowOverlay = false;
      });
      Timer(const Duration(milliseconds: 350), () {
        if (mounted) {
          setState(() {
            isActive = widget.active;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (isActive)
          Positioned.fill(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 350),
              opacity: _shouldShowOverlay ? 1.0 : 0.0,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 7.5, sigmaY: 7.5),
                child: Padding(
                  padding: EdgeInsets.only(top: 18.h),
                  child: Stack(
                    children: [
                      Transform.rotate(
                        angle: 20,
                        child: Center(
                          child: Container(
                            color: Colors.black.withOpacity(.06),
                            width: 350.h,
                            height: context.width * 2,
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.black.withOpacity(.07),
                        child: Container(
                          alignment: Alignment.center,
                          child: const MainHammerLoader(),
                        ),
                      ),
                      Positioned(
                          top: -5.h - 18.h,
                          child: SizedBox(
                            height: 126.h,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 28.w),
                                  child: const Row(
                                    children: [
                                      MainBackButton(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ).animate().fade(delay: 5.seconds))
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
//  Positioned.fill(
//           child: TweenAnimationBuilder(
//               tween: Tween<double>(begin: 0.0, end: 1.0),
//               duration: const Duration(milliseconds: 500),
//               child: BackdropFilter(
//                 filter: ImageFilter.blur(sigmaX: 7.5, sigmaY: 7.5),
//                 child: Padding(
//                   padding: EdgeInsets.only(top: 18.h),
//                   child: Stack(
//                     children: [
//                       Transform.rotate(
//                         angle: 20,
//                         child: Center(
//                           child: Container(
//                             color: Colors.black.withOpacity(.06),
//                             width: 350.h,
//                             height: context.width * 2,
//                           ),
//                         ),
//                       ),
//                       Container(
//                         color: Colors.black.withOpacity(.07),
//                         child: Container(
//                           alignment: Alignment.center,
//                           child: const MainHammerLoader(),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               builder: (context, opacity, child) {
//                 return child!;
//               }),
//         ),