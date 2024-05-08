import 'package:freezed_annotation/freezed_annotation.dart';

part 'faq.freezed.dart';
part 'faq.g.dart';

@freezed
class FAQ with _$FAQ {
  const factory FAQ({
    @JsonKey(name: "question_ar") required String questionAr,
    @JsonKey(name: "question_en") required String questionEn,
    @JsonKey(name: "answer_ar") required String answerAr,
    @JsonKey(name: "answer_en") required String answerEn,
  }) = _FAQ;
  factory FAQ.fromJson(Map<String, dynamic> json) => _$FAQFromJson(json);
}
