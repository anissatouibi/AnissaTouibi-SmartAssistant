import 'package:smart_assistant_app/i18n/strings.g.dart';
import 'package:smart_assistant_app/presentation/common/theme/app_text_styles.dart';
import 'package:smart_assistant_app/presentation/common/utils/bottomSheet/BottomSheetHelper.dart';
import 'package:smart_assistant_app/presentation/common/widgets/animated_assets/operation_status_animated_widget.dart';
import 'package:smart_assistant_app/presentation/common/widgets/buttons/auc_text_button.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OperationStatusSheetContent extends StatelessWidget {
  const OperationStatusSheetContent(
      {super.key, required this.text, required this.statusType, this.textStyle});
  final String text;
  final SheetStatusType statusType;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 26.h),
          OperationStatusAnimatedWidget(statusType: statusType),
          SizedBox(height: 40.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: AutoSizeText(
              text,
              style: textStyle ?? AppTextStyles.px14wRegular(context),
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(height: 27.h),
          Center(
            child: SizedBox(
                height: 44.h,
                width: double.infinity,
                child: MainTextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  text: statusType == SheetStatusType.success ? t.common.done : t.common.back,
                )),
          ),
          SizedBox(height: 28.h),
        ],
      ),
    );
  }
}
