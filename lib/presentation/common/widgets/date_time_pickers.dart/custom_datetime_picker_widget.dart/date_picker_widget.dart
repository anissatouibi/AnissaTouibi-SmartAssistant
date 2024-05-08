import 'dart:math';

import 'package:smart_assistant_app/presentation/common/widgets/date_time_pickers.dart/custom_datetime_picker_widget.dart/date_picker_constants.dart';
import 'package:smart_assistant_app/presentation/common/widgets/date_time_pickers.dart/custom_datetime_picker_widget.dart/date_picker_theme.dart';
import 'package:smart_assistant_app/presentation/common/widgets/date_time_pickers.dart/custom_datetime_picker_widget.dart/date_time_formatter.dart';
import 'package:smart_assistant_app/presentation/common/widgets/date_time_pickers.dart/custom_datetime_picker_widget.dart/i18n/date_picker_i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'datetime_picker_widget.dart';

/// Solar months of 31 days.
const List<int> solarMonthsOf31Days = <int>[1, 3, 5, 7, 8, 10, 12];

/// DatePicker widget.
@Deprecated(
  'Use DateTimePickerWidget instead',
)
class DatePickerWidget extends StatelessWidget {
  const DatePickerWidget({
    super.key,
    this.onMonthChangeStartWithFirstDate = false,
    this.minDateTime,
    this.maxDateTime,
    this.initDateTime,
    this.dateFormat = DATETIME_PICKER_DATE_FORMAT,
    this.dateFormatSeparator = DATE_FORMAT_SEPARATOR,
    this.locale = DATETIME_PICKER_LOCALE_DEFAULT,
    this.pickerTheme = DateTimePickerTheme.Default,
    this.onCancel,
    this.onChange,
    this.onConfirm,
  });

  final DateTime? minDateTime, maxDateTime, initDateTime;
  final String dateFormat;
  final String dateFormatSeparator;
  final DateTimePickerLocale locale;
  final DateTimePickerTheme pickerTheme;

  final DateVoidCallback? onCancel;
  final DateValueCallback? onChange, onConfirm;
  final bool onMonthChangeStartWithFirstDate;

  @override
  Widget build(BuildContext context) {
    return DateTimePickerWidget(
      minDateTime: minDateTime,
      maxDateTime: maxDateTime,
      initDateTime: initDateTime,
      dateFormat: dateFormat,
      dateFormatSeparator: dateFormatSeparator,
      locale: locale,
      pickerTheme: pickerTheme,
      onCancel: onCancel,
      onChange: onChange,
      onConfirm: onConfirm,
      onMonthChangeStartWithFirstDate: onMonthChangeStartWithFirstDate,
    );
  }
}
