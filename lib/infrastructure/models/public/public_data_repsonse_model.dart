import 'package:smart_assistant_app/infrastructure/models/public/faq.dart';
import 'package:smart_assistant_app/infrastructure/models/public/privacy_policy.dart';
import 'package:smart_assistant_app/infrastructure/models/public/term_and_condition.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'public_data_repsonse_model.freezed.dart';

@freezed
class PublicDataResponseModel with _$PublicDataResponseModel {
  const factory PublicDataResponseModel({
    required List<FAQ> faqs,
    required List<TermAndCondition> termsAndConditions,
    required List<PrivacyPolicy> privacyPolicies,
  }) = _PublicDataResponseModel;
}
