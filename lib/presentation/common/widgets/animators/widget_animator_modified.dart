import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimatorModified extends StatefulWidget {
  final Widget? child;
  final Duration? time;
  final int listItemIndex;

  const AnimatorModified({super.key, this.child, this.time, required this.listItemIndex});

  @override
  _AnimatorModifiedState createState() => _AnimatorModifiedState();
}

class _AnimatorModifiedState extends State<AnimatorModified> with SingleTickerProviderStateMixin {
  late Timer timer;
  late AnimationController animationController;
  late Animation animation;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: const Duration(milliseconds: 290), vsync: this);
    animation = CurvedAnimation(parent: animationController, curve: Curves.easeInOut);
    timer = Timer(widget.time!, animationController.forward);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      child: widget.child,
      builder: (BuildContext context, Widget? child) {
        Widget animatedChild = child!;
        animatedChild.animate().fadeIn();
        if (widget.listItemIndex != -1) {
          animatedChild = animatedChild.animate().slideX(
              begin: -1.0,
              end: 0.0,
              delay: 100.ms + (100.ms * widget.listItemIndex),
              duration: 400.ms);
        } else {
          animatedChild = animatedChild.animate().slideY(begin: -0.1, end: 0.0, duration: 400.ms);
        }
        return animatedChild.animate().blurXY(begin: 1.0, end: 0.0, duration: 1500.ms);
      },
    );
  }
}

Timer? timer;
Duration duration = const Duration();

wait() {
  if (timer == null || !timer!.isActive) {
    timer = Timer(const Duration(microseconds: 120), () {
      duration = const Duration();
    });
  }
  duration += const Duration(milliseconds: 100);
  return duration;
}

class WidgetAnimatorForListItem extends StatelessWidget {
  final Widget? child;
  final int listItemIndex;
  const WidgetAnimatorForListItem({super.key, this.child, this.listItemIndex = -1});

  @override
  Widget build(BuildContext context) {
    return AnimatorModified(
      time: wait(),
      listItemIndex: listItemIndex,
      child: child,
    );
  }
}
