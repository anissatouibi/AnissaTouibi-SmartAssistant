import 'dart:async';

import 'package:smart_assistant_app/presentation/common/theme/app_colors.dart';
import 'package:smart_assistant_app/presentation/common/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class MainPinCodeField extends StatelessWidget {
  const MainPinCodeField(
      {super.key,
      required this.textController,
      required this.errorController,
      required this.onComplete});
  final TextEditingController textController;
  final StreamController<ErrorAnimationType> errorController;
  final Function(String) onComplete;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: PinCodeTextField(
        textStyle:
            AppTextStyles.px14wBold(context).copyWith(color: AppColors.whiteColor, fontSize: 24.sp),
        enablePinAutofill: true,
        hintCharacter: '',
        appContext: context,
        showCursor: true,
        cursorHeight: 22.h,
        length: 4,
        animationType: AnimationType.fade,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        ],
        pinTheme: PinTheme(
          borderWidth: 1.sp,
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 46.h,
          fieldWidth: 46.h,
          activeColor: AppColors.primaryRed8AColor,
          inactiveColor: AppColors.primaryRed8AColor,
          selectedColor: AppColors.primaryRed8AColor,
          inactiveFillColor: AppColors.primaryRed8AColor,
          selectedFillColor: AppColors.primaryRed8AColor.withOpacity(0.65),
          activeFillColor: AppColors.primaryRed8AColor,
        ),
        cursorColor: AppColors.blackColor,
        animationDuration: const Duration(milliseconds: 300),
        enableActiveFill: true,
        errorAnimationController: errorController,
        controller: textController,
        keyboardType: TextInputType.number,
        onCompleted: (value) {
          onComplete(value);
        },
        onChanged: (value) {},
      ),
    );
  }
}
