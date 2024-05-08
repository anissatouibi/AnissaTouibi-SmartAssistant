import 'package:smart_assistant_app/presentation/common/constants/assets_constants.dart';
import 'package:smart_assistant_app/presentation/common/utils/bottomSheet/BottomSheetHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class OperationStatusAnimatedWidget extends StatefulWidget {
  const OperationStatusAnimatedWidget({super.key, required this.statusType});
  final SheetStatusType statusType;

  @override
  State<OperationStatusAnimatedWidget> createState() => _OperationStatusAnimatedWidgetState();
}

class _OperationStatusAnimatedWidgetState extends State<OperationStatusAnimatedWidget>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 123.h,
      width: 123.h,
      child: Lottie.asset(
        widget.statusType == SheetStatusType.success
            ? MainAssetConstantsAnimations.successOperationAnimation
            : MainAssetConstantsAnimations.failureOperationAnimation,
        alignment: Alignment.center,
        fit: BoxFit.cover,
        repeat: false,
        controller: _controller,
        onLoaded: (composition) {
          _controller
            ..duration =
                composition.duration * (widget.statusType == SheetStatusType.success ? 0.5 : .65)
            ..forward();
        },
      ),
    );
  }
}
