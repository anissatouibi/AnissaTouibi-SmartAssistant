import 'package:freezed_annotation/freezed_annotation.dart';

part 'term_and_condition.freezed.dart';
part 'term_and_condition.g.dart';

@freezed
class TermAndCondition with _$TermAndCondition {
  const factory TermAndCondition({
    @JsonKey(name: "title_ar") required String titleAr,
    @JsonKey(name: "title_en") required String titleEn,
    @JsonKey(name: "content_ar") required String contentAr,
    @JsonKey(name: "content_en") required String contentEn,
  }) = _TermAndCondition;
  factory TermAndCondition.fromJson(Map<String, dynamic> json) => _$TermAndConditionFromJson(json);
}
