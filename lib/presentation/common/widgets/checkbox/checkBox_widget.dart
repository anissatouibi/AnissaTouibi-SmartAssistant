import 'package:smart_assistant_app/presentation/common/theme/app_colors.dart';
import 'package:smart_assistant_app/presentation/common/widgets/checkbox/custom_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainCheckboxWidget extends StatefulWidget {
  final bool? initialState;
  final ValueChanged<bool> onChange;
  final bool checkable;
  final bool uncheckable;
  final bool radio;
  final bool enabled;
  final Color? fillColor;
  final Color? uncheckedFillColor;

  const MainCheckboxWidget({
    super.key,
    this.initialState = false,
    required this.onChange,
    this.checkable = true,
    this.uncheckable = true,
    this.radio = false,
    this.enabled = true,
    this.fillColor,
    this.uncheckedFillColor,
  });
  @override
  _MainCheckboxWidgetState createState() => _MainCheckboxWidgetState();
}

class _MainCheckboxWidgetState extends State<MainCheckboxWidget> {
  bool? currentState = false;
  @override
  void initState() {
    super.initState();
    currentState = widget.initialState;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.sp,
      width: 30.sp,
      child: MyCustomCheckBox(
          checkBoxSize: 18.sp,
          checkedIcon: Icons.check,
          borderRadius: widget.radio ? 50 : 3,
          checkable: widget.checkable,
          uncheckable: widget.uncheckable,
          checkedFillColor: widget.fillColor ?? AppColors.primaryRed8AColor,
          checkedIconColor: Colors.white,
          uncheckedIconColor: AppColors.backgroundLightPurple,
          uncheckedIcon: null,
          uncheckedFillColor: widget.uncheckedFillColor ?? AppColors.backgroundLightPurple,
          borderColor: widget.fillColor != null
              ? AppColors.primaryBlackishColor
              : AppColors.primaryRed8AColor,
          borderWidth: 1.25.sp,
          shouldShowBorder: currentState! ? false : true,
          value: currentState,
          onChanged: (value) {
            setState(() {
              currentState = value;
            });
            widget.onChange(value);
          }),
    );
  }
}
