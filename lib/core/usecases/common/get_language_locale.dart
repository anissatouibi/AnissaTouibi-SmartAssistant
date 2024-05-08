import 'dart:io';

import 'package:smart_assistant_app/core/erros/failures.dart';
import 'package:smart_assistant_app/core/extensions/dartz.dart';
import 'package:smart_assistant_app/core/usecases/usecase.dart';
import 'package:smart_assistant_app/infrastructure/datasources/local_datasources/common_local_data_source.dart';
import 'package:smart_assistant_app/presentation/common/cubit/language/language_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@singleton
class GetLanguageLocale implements UnawaitedUsecase<LocaleLanguage, NoParams> {
  final CommonLocalDataSource localDataSource;

  GetLanguageLocale(this.localDataSource);

  @override
  Either<Failure, LocaleLanguage> call(NoParams _) {
    final languageEither = localDataSource.getCachedLanguage();
    if (languageEither.isLeft()) return Left(languageEither.asLeft());
    final cachedLocaleLang = languageEither.asRight();
    if (cachedLocaleLang != null) return Right(cachedLocaleLang);
    // Get default device locale
    String languageCode = Platform.localeName.split('_')[0];
    if (LocaleLanguage.values.any((element) => element.name == languageCode)) {
      return const Right(
        // GeneralUtils.getLocaleLanguageFromCode(languageCode)
        //TODO uncomment
        LocaleLanguage.en,
      );
    } else {
      return const Right(LocaleLanguage.en);
    }
  }
}
