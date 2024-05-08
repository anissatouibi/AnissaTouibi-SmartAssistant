import 'package:smart_assistant_app/i18n/strings.g.dart';
import 'package:smart_assistant_app/presentation/common/theme/app_text_styles.dart';
import 'package:smart_assistant_app/presentation/common/widgets/buttons/auc_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConfirmationSheetContent extends StatelessWidget {
  const ConfirmationSheetContent(
      {super.key,
      required this.text,
      required this.onConfirmCallback,
      this.confirmationTitle,
      this.confirmationTitleTextStyle});
  final String text;
  final Function onConfirmCallback;
  final String? confirmationTitle;
  final TextStyle? confirmationTitleTextStyle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 24.h),
          Row(
            children: [
              Text(
                confirmationTitle ?? context.t.common.confirm,
                style: confirmationTitleTextStyle ?? AppTextStyles.px19wMedium(context),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          Text(text, style: AppTextStyles.px14wRegular(context)),
          SizedBox(height: 24.h),
          Row(children: [
            Flexible(
              child: MainTextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    onConfirmCallback();
                  },
                  text: context.t.common.confirm),
            ),
            SizedBox(width: 20.w),
            Flexible(
              child: MainTextButton(
                onPressed: () => Navigator.pop(context),
                text: context.t.common.cancel,
                type: MainBottonType.blackBorderTransparent,
              ),
            ),
          ]),
          SizedBox(height: 28.h),
        ],
      ),
    );
  }
}
