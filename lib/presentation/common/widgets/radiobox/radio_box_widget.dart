import 'package:smart_assistant_app/presentation/common/theme/app_colors.dart';
import 'package:smart_assistant_app/presentation/common/widgets/radiobox/custom_radio_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainRadioBoxWidget extends StatelessWidget {
  const MainRadioBoxWidget(
      {super.key,
      required this.itemValue,
      required this.currentValue,
      required this.onChanged,
      this.bgColor,
      this.inactiveBorderColor,
      this.smallSelectedInnerCircle = false});
  final int itemValue;
  final int currentValue;
  final Color? bgColor;
  final Color? inactiveBorderColor;
  final Function(int) onChanged;
  final bool smallSelectedInnerCircle;

  @override
  Widget build(BuildContext context) {
    return CustomRadiobox(
      activeBgColor: bgColor ?? AppColors.whiteColor,
      activeBorderColor: AppColors.primaryRed8AColor,
      customBgColor: AppColors.whiteColor,
      groupValue: currentValue,
      inactiveBgColor: bgColor ?? AppColors.whiteColor,
      inactiveBorderColor: inactiveBorderColor ?? AppColors.primaryRed8AColor,
      inactiveRadioColor: bgColor ?? AppColors.whiteColor,
      onChanged: (value) => onChanged(value),
      radioColor: AppColors.primaryRed8AColor,
      value: itemValue,
      size: 20.h,
      smallSelectedInnerCircle: smallSelectedInnerCircle,
    );
  }
}
