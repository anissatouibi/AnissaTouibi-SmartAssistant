import 'package:smart_assistant_app/presentation/common/constants/ui_constants.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String toDashedDateFormat() {
    return DateFormat(UIConstants.dashedDateFormat).format(this);
  }

  String toSlashedDateFormat() {
    return DateFormat(UIConstants.slashedDateFormat).format(this);
  }

  String toHourFormat() {
    return DateFormat(UIConstants.hourFormat).format(this);
  }

  String toMinuteFormat() {
    return DateFormat(UIConstants.minuteFormat).format(this);
  }

  bool isSameDay(DateTime date) {
    return year == date.year && month == date.month && day == date.day;
  }

  bool isAfterOrEqualTo(DateTime dateTime) {
    final date = this;
    final isAtSameMomentAs = dateTime.isAtSameMomentAs(date);
    return isAtSameMomentAs | date.isAfter(dateTime);
  }

  bool isBeforeOrEqualTo(DateTime dateTime) {
    final date = this;
    final isAtSameMomentAs = dateTime.isAtSameMomentAs(date);
    return isAtSameMomentAs | date.isBefore(dateTime);
  }

  bool isBetween(
    DateTime fromDateTime,
    DateTime toDateTime,
  ) {
    final date = this;
    final isAfter = date.isAfterOrEqualTo(fromDateTime);
    final isBefore = date.isBeforeOrEqualTo(toDateTime);
    return isAfter && isBefore;
  }
}

class TimestampSerializer implements JsonConverter<DateTime?, dynamic> {
  const TimestampSerializer();

  @override
  DateTime? fromJson(dynamic timestamp) =>
      DateTime.tryParse(timestamp ?? '') != null ? DateTime.parse(timestamp).toLocal() : null;

  @override
  toJson(DateTime? date) => date.toString();
}
