import 'package:freezed_annotation/freezed_annotation.dart';

part 'privacy_policy.freezed.dart';
part 'privacy_policy.g.dart';

@freezed
class PrivacyPolicy with _$PrivacyPolicy {
  const factory PrivacyPolicy({
    @JsonKey(name: "title_ar") required String titleAr,
    @JsonKey(name: "title_en") required String titleEn,
    @JsonKey(name: "content_ar") required String contentAr,
    @JsonKey(name: "content_en") required String contentEn,
  }) = _PrivacyPolicy;
  factory PrivacyPolicy.fromJson(Map<String, dynamic> json) => _$PrivacyPolicyFromJson(json);
}
