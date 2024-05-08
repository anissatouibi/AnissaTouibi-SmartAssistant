library wheel_slider;

import 'package:smart_assistant_app/presentation/common/widgets/numbers/wheel_slider/wheel_chooser.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//ignore: must_be_immutable
class WheelSlider extends StatefulWidget {
  final double horizontalListHeight, horizontalListWidth, verticalListHeight, verticalListWidth;
  final int initIndex;
  final Function(dynamic) onValueChanged;
  final double itemSize;
  final double perspective;
  final double listWidth;
  final bool isInfinite;
  final bool horizontal;
  final double squeeze;
  final Color? lineColor;
  final Color pointerColor;
  final double pointerHeight, pointerWidth;
  final Widget background;
  final bool isVibrate;

  final String hapticFeedback;
  final bool showPointer;
  final Widget? pointer;
  final Widget? customPointer;
  final TextStyle? selectedNumberStyle, unSelectedNumberStyle;
  final List<Widget> children;
  int? currentIndex;
  final ScrollPhysics? scrollPhysics;
  final FixedExtentScrollController? controller;
  final bool allowPointerTappable;
  final int minValue;
  final int maxValue;

  WheelSlider({
    super.key,
    this.horizontalListHeight = 50,
    this.horizontalListWidth = double.infinity,
    this.verticalListHeight = 400.0,
    this.verticalListWidth = 50.0,
    required this.initIndex,
    required this.onValueChanged,
    this.itemSize = 10,
    this.perspective = 0.0007,
    this.listWidth = 50,
    this.isInfinite = true,
    this.horizontal = true,
    this.squeeze = 1.0,
    this.lineColor = Colors.black87,
    this.pointerColor = Colors.black,
    this.pointerHeight = 50.0,
    this.pointerWidth = 3.0,
    this.background = const Center(),
    this.isVibrate = true,
    HapticFeedbackType hapticFeedbackType = HapticFeedbackType.vibrate,
    this.showPointer = true,
    this.customPointer,
    this.scrollPhysics,
    this.allowPointerTappable = true,
    this.controller,
    required this.minValue,
    required this.maxValue,
  })  : assert(perspective <= 0.01),
        selectedNumberStyle = null,
        unSelectedNumberStyle = null,
        children = barUI(initIndex, horizontal, lineColor),
        currentIndex = null,
        hapticFeedback = hapticFeedbackType.value,
        pointer = customPointer == null
            ? pointerWidget(customPointer, horizontal, pointerHeight, pointerWidth, pointerColor)
            : null;
  static Widget? pointerWidget(Widget? customPointer, bool horizontal, double pointerHeight,
      double pointerWidth, Color pointerColor) {
    return customPointer == null
        ? Container(
            height: horizontal ? pointerHeight : pointerWidth,
            width: horizontal ? pointerWidth : pointerHeight,
            color: pointerColor,
          )
        : null;
  }

  static List<Widget> barUI(totalCount, horizontal, lineColor) {
    return List.generate(
      totalCount + 1,
      (index) => Container(
        height: horizontal
            ? multipleOfFive(index)
                ? 35.0
                : 20.0
            : 1.5,
        width: horizontal
            ? 1.5
            : multipleOfFive(index)
                ? 35.0
                : 20.0,
        alignment: Alignment.center,
        child: Container(
          height: horizontal
              ? multipleOfFive(index)
                  ? 35.0
                  : 20.0
              : 1.5,
          width: horizontal
              ? 1.5
              : multipleOfFive(index)
                  ? 35.0
                  : 20.0,
          color: lineColor,
          alignment: Alignment.center,
        ),
      ),
    );
  }

  /// Displays numbers instead of lines.

  WheelSlider.number({
    super.key,
    this.horizontalListHeight = 50,
    this.horizontalListWidth = double.infinity,
    this.verticalListHeight = 400.0,
    this.verticalListWidth = 50.0,
    required this.minValue,
    required this.maxValue,
    required this.initIndex,
    required this.onValueChanged,
    this.itemSize = 40,
    this.perspective = 0.0007,
    this.listWidth = 50,
    this.isInfinite = true,
    this.horizontal = true,
    this.squeeze = 1.0,
    this.pointerColor = Colors.black,
    this.pointerHeight = 50.0,
    this.pointerWidth = 3.0,
    this.background = const Center(),
    this.isVibrate = true,
    HapticFeedbackType hapticFeedbackType = HapticFeedbackType.vibrate,
    this.showPointer = false,
    this.customPointer,
    this.selectedNumberStyle = const TextStyle(fontWeight: FontWeight.bold),
    this.unSelectedNumberStyle = const TextStyle(),
    required this.currentIndex,
    this.scrollPhysics,
    this.controller,
    this.allowPointerTappable = true,
  })  : assert(minValue <= maxValue),
        lineColor = null,
        children = _generateNumberWidgets(
            minValue, maxValue, currentIndex!, selectedNumberStyle!, unSelectedNumberStyle!),
        hapticFeedback = hapticFeedbackType.value,
        pointer = customPointer == null
            ? pointerWidget(customPointer, horizontal, pointerHeight, pointerWidth, pointerColor)
            : null;
// Function to generate the number widgets
  static List<Widget> _generateNumberWidgets(int minValue, int maxValue, int currentIndex,
      TextStyle selectedNumberStyle, TextStyle unSelectedNumberStyle) {
    final listOfNumbers = List<int>.generate(maxValue - minValue + 1, (index) => minValue + index);

    final List<Widget> numberWidgets = [];
    for (int value = minValue; value <= maxValue; value++) {
      final index = listOfNumbers.indexOf(value);

      numberWidgets.add(
        Container(
          alignment: Alignment.center,
          child: Text(
            value.toString(),
            style: index == currentIndex ? selectedNumberStyle : unSelectedNumberStyle,
          ),
        ),
      );
    }
    return numberWidgets;
  }

  static bool multipleOfFive(int n) {
    while (n > 0) {
      n = n - 5;
    }
    if (n == 0) {
      return true;
    }
    return false;
  }

  /// Gives you the option to replace with your own custom Widget(s).
  WheelSlider.customWidget({
    super.key,
    this.horizontalListHeight = 50,
    this.horizontalListWidth = double.infinity,
    this.verticalListHeight = 400.0,
    this.verticalListWidth = 50.0,
    required this.initIndex,
    required this.onValueChanged,
    this.itemSize = 10,
    this.perspective = 0.0007,
    this.listWidth = 50,
    this.isInfinite = true,
    this.horizontal = true,
    this.squeeze = 1.0,
    this.pointerColor = Colors.black,
    this.pointerHeight = 50.0,
    this.pointerWidth = 3.0,
    required this.children,
    this.background = const Center(),
    this.isVibrate = true,
    HapticFeedbackType hapticFeedbackType = HapticFeedbackType.vibrate,
    this.showPointer = true,
    this.customPointer,
    this.scrollPhysics,
    this.controller,
    this.allowPointerTappable = true,
    required this.minValue,
    required this.maxValue,
  })  : assert(perspective <= 0.01),
        lineColor = null,
        selectedNumberStyle = null,
        unSelectedNumberStyle = null,
        currentIndex = null,
        hapticFeedback = hapticFeedbackType.value,
        pointer = customPointer == null
            ? pointerWidget(customPointer, horizontal, pointerHeight, pointerWidth, pointerColor)
            : null;

  @override
  State<WheelSlider> createState() => _WheelSliderState();
}

class HapticFeedbackType {
  final String value;

  const HapticFeedbackType._(this.value);

  static const HapticFeedbackType vibrate = HapticFeedbackType._('vibrate');
  static const HapticFeedbackType lightImpact = HapticFeedbackType._('light');
  static const HapticFeedbackType mediumImpact = HapticFeedbackType._('medium');
  static const HapticFeedbackType heavyImpact = HapticFeedbackType._('heavy');
  static const HapticFeedbackType selectionClick = HapticFeedbackType._('selectionClick');
  static List<HapticFeedbackType> values = [
    vibrate,
    lightImpact,
    mediumImpact,
    heavyImpact,
    selectionClick
  ];

  factory HapticFeedbackType.fromString(String input) =>
      values.firstWhere((element) => element.value == input);
}

class _WheelSliderState extends State<WheelSlider> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.horizontal ? widget.horizontalListHeight : widget.verticalListHeight,
      width: widget.horizontal ? widget.horizontalListWidth : widget.verticalListWidth,
      child: Stack(
        alignment: Alignment.center,
        children: [
          widget.background,
          WheelChooser.custom(
            onValueChanged: (val) async {
              if (widget.isVibrate) {
                if (widget.hapticFeedback == 'vibrate') {
                  await HapticFeedback.vibrate();
                } else if (widget.hapticFeedback == 'light') {
                  await HapticFeedback.lightImpact();
                } else if (widget.hapticFeedback == 'medium') {
                  await HapticFeedback.mediumImpact();
                } else if (widget.hapticFeedback == 'heavy') {
                  await HapticFeedback.heavyImpact();
                } else if (widget.hapticFeedback == 'selectionClick') {
                  await HapticFeedback.selectionClick();
                } else {
                  await HapticFeedback.vibrate();
                }
              }
              if (mounted) {
                setState(() {
                  widget.onValueChanged(val);
                });
              }
            },
            startPosition: widget.initIndex,
            horizontal: widget.horizontal,
            isInfinite: widget.isInfinite,
            itemSize: widget.itemSize,
            perspective: widget.perspective,
            listWidth: widget.listWidth,
            squeeze: widget.squeeze,
            physics: widget.scrollPhysics,
            controller: widget.controller,
            children: widget.children,
          ),
          IgnorePointer(
            ignoring: widget.allowPointerTappable,
            child: Visibility(
              visible: widget.showPointer,
              child: widget.customPointer ?? widget.pointer!,
            ),
          ), // For details on this widget check out the document here https://api.flutter.dev/flutter/widgets/IgnorePointer-class.html
        ],
      ),
    );
  }
}
