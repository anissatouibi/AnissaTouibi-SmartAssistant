import 'package:smart_assistant_app/presentation/common/theme/app_colors.dart';
import 'package:smart_assistant_app/presentation/common/theme/app_text_styles.dart';
import 'package:smart_assistant_app/presentation/common/widgets/date_time_pickers.dart/custom_datetime_picker_widget.dart/date_picker_theme.dart';
import 'package:smart_assistant_app/presentation/common/widgets/date_time_pickers.dart/custom_datetime_picker_widget.dart/datetime_picker_widget.dart';
import 'package:smart_assistant_app/presentation/common/widgets/date_time_pickers.dart/fts_cupertino_date_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FtsDatePickerWidget extends StatefulWidget {
  const FtsDatePickerWidget({
    super.key,
    required this.onChanged,
    this.minDate,
    required this.initialDate,
    this.maxDate,
    this.enabled = true,
  });
  final ValueChanged<DateTime> onChanged;
  final DateTime initialDate;
  final DateTime? minDate;
  final DateTime? maxDate;
  final bool enabled;

  @override
  State<FtsDatePickerWidget> createState() => _FtsDatePickerWidgetState();
}

class _FtsDatePickerWidgetState extends State<FtsDatePickerWidget> {
  DateTime? currentDate;
  @override
  void initState() {
    super.initState();
    currentDate = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !widget.enabled,
      child: SizedBox(
        height: 118.h,
        child: Row(
          children: [
            // SizedBox(width: 41.w),
            const Spacer(),

            Flexible(
              flex: 5,
              child: DateTimePickerWidget(
                  minDateTime: widget.minDate,
                  maxDateTime: widget.maxDate,
                  initDateTime: widget.initialDate,
                  dateFormat: 'dd MMM yyyy',
                  pickerTheme: DateTimePickerTheme(
                    backgroundColor: AppColors.whiteColor,
                    itemTextStyle: AppTextStyles.px20wBold(context).toPrimaryGreyColor,
                    itemHeight: 47.h,
                    selectionOverlay: const SizedBox.shrink(),
                    showTitle: false,
                  ),
                  onChange: (dateTime, selectedIndex) {
                    widget.onChanged(dateTime);
                  }),
            ),
            const Spacer(),

            // SizedBox(width: 41.w),
          ],
        ),
      ),
    );
  }
}
