import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum RadioType {
  basic,
  square,
  custom,
  blunt,
}

class CustomRadiobox<T> extends StatefulWidget {
  const CustomRadiobox(
      {super.key,
      required this.value,
      required this.groupValue,
      required this.onChanged,
      this.size = 25,
      this.type = RadioType.basic,
      required this.radioColor,
      required this.activeBgColor,
      required this.inactiveBgColor,
      required this.activeBorderColor,
      required this.inactiveBorderColor,
      this.activeIcon = const Icon(
        Icons.check,
        size: 20,
      ),
      this.inactiveIcon,
      required this.customBgColor,
      this.autofocus = false,
      this.focusNode,
      this.toggleable = false,
      required this.inactiveRadioColor,
      this.smallSelectedInnerCircle = false});

  /// type of [RadioType] which is of four type is basic, sqaure, circular and custom
  final RadioType type;

  /// type of [double] which is GFSize ie, small, medium and large and can use any double value
  final double size;

  /// type pf [Color] used to change the checkcolor when the radio button is active
  final Color radioColor;

  /// type pf [Color] used to change the checkcolor when the radio button is not active
  final Color inactiveRadioColor;

  /// type of [Color] used to change the backgroundColor of the active radio button
  final Color activeBgColor;

  /// type of [Color] used to change the backgroundColor of the inactive radio button
  final Color inactiveBgColor;

  /// type of [Color] used to change the border color of the active radio button
  final Color activeBorderColor;

  /// type of [Color] used to change the border color of the inactive radio button
  final Color inactiveBorderColor;

  /// Called when the user checks or unchecks the radio button
  final ValueChanged<T>? onChanged;

  ///type of Widget used to change the  radio button's active icon
  final Widget activeIcon;

  ///type of [Widget] used to change the  radio button's inactive icon
  final Widget? inactiveIcon;

  /// type of [Color] used to change the background color of the custom active  radio button only
  final Color customBgColor;

  /// on true state this widget will be selected as the initial focus
  /// when no other node in its scope is currently focused
  final bool autofocus;

  /// an optional focus node to use as the focus node for this widget.
  final FocusNode? focusNode;

  /// The value represented by this radio button.
  final T value;

  /// The currently selected value for a group of radio buttons. Radio button is considered selected if its [value] matches the
  /// [groupValue].
  final T groupValue;

  /// sets the radio value
  final bool toggleable;

  /// small selected inner circle
  final bool smallSelectedInnerCircle;
  @override
  _CustomRadioboxState<T> createState() => _CustomRadioboxState<T>();
}

class _CustomRadioboxState<T> extends State<CustomRadiobox<T>> with TickerProviderStateMixin {
  bool get enabled => widget.onChanged != null;
  bool selected = false;
  T? groupValue;

  void onStatusChange() {
    groupValue = widget.value;
    _handleChanged(widget.value == groupValue);
  }

  void _handleChanged(bool selected) {
    if (selected) {
      widget.onChanged!(widget.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    selected = widget.value == widget.groupValue;
    return InkWell(
        borderRadius: widget.type == RadioType.basic ||
                widget.type == RadioType.blunt ||
                widget.type == RadioType.custom
            ? BorderRadius.circular(50)
            : widget.type == RadioType.square
                ? BorderRadius.circular(0)
                : BorderRadius.circular(10),
        enableFeedback: enabled,
        onTap: onStatusChange,
        child: Container(
            height: widget.size,
            width: widget.size,
            decoration: BoxDecoration(
                color: selected ? widget.activeBgColor : widget.inactiveBgColor,
                borderRadius: widget.type == RadioType.basic || widget.type == RadioType.custom
                    ? BorderRadius.circular(50)
                    : widget.type == RadioType.square
                        ? BorderRadius.circular(0)
                        : BorderRadius.circular(10),
                border: Border.all(
                    color: selected ? widget.activeBorderColor : widget.inactiveBorderColor,
                    width: 1.5.h)),
            child: widget.type == RadioType.basic || widget.type == RadioType.square
                ? Stack(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                      ),
                      Center(
                        child: Container(
                          width: widget.size * (widget.smallSelectedInnerCircle ? 0.52 : 0.68),
                          height: widget.size * (widget.smallSelectedInnerCircle ? 0.52 : 0.68),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: selected ? widget.radioColor : widget.inactiveRadioColor),
                        ),
                      )
                    ],
                  )
                : widget.type == RadioType.blunt
                    ? Stack(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                          ),
                          Container(
                            margin: const EdgeInsets.all(5),
                            alignment: Alignment.center,
                            width: widget.size * 0.8,
                            height: widget.size * 0.8,
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(50)),
                                color: widget.customBgColor),
                          )
                        ],
                      )
                    : widget.type == RadioType.custom
                        ? widget.activeIcon
                        : widget.inactiveIcon));
  }
}
