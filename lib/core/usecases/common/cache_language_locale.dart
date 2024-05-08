import 'package:smart_assistant_app/core/erros/failures.dart';
import 'package:smart_assistant_app/core/extensions/dartz.dart';
import 'package:smart_assistant_app/core/usecases/usecase.dart';
import 'package:smart_assistant_app/infrastructure/datasources/local_datasources/common_local_data_source.dart';
import 'package:smart_assistant_app/presentation/common/cubit/language/language_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@singleton
class CacheLanguageLocale implements Usecase<Unit, LocaleLanguage> {
  final CommonLocalDataSource localDataSource;

  CacheLanguageLocale(this.localDataSource);

  @override
  Future<Either<Failure, Unit>> call(LocaleLanguage param) async {
    final languageEither = localDataSource.cacheLanguage(param);
    if (languageEither.isLeft()) return Left(languageEither.asLeft());
    return const Right(unit);
  }
}
