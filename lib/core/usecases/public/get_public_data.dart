import 'package:smart_assistant_app/core/erros/failures.dart';
import 'package:smart_assistant_app/core/extensions/dartz.dart';
import 'package:smart_assistant_app/core/usecases/usecase.dart';
import 'package:smart_assistant_app/infrastructure/models/public/faq.dart';
import 'package:smart_assistant_app/infrastructure/models/public/privacy_policy.dart';
import 'package:smart_assistant_app/infrastructure/models/public/public_data_repsonse_model.dart';
import 'package:smart_assistant_app/infrastructure/models/public/term_and_condition.dart';
import 'package:smart_assistant_app/infrastructure/repositories/common_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@singleton
class GetPublicData implements Usecase<PublicDataResponseModel, NoParams> {
  final ICommonRepository _repository;

  GetPublicData(this._repository);

  @override
  Future<Either<Failure, PublicDataResponseModel>> call(NoParams noParams) async {
    final eithers = await Future.wait([
      _repository.getAppSettingsData(),
    ]);
    if (eithers.any((e) => e.isLeft())) {
      return Left(eithers.firstWhere((e) => e.isLeft()).asLeft());
    }

    List<FAQ> faqs = eithers[0].asRight() as List<FAQ>;
    List<TermAndCondition> termsAndConditions = eithers[1].asRight() as List<TermAndCondition>;
    List<PrivacyPolicy> privacyPolicies = eithers[2].asRight() as List<PrivacyPolicy>;
    final data = PublicDataResponseModel(
        faqs: faqs, termsAndConditions: termsAndConditions, privacyPolicies: privacyPolicies);
    return Right(data);
  }
}
