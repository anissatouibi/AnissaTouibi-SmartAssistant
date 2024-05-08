import 'package:smart_assistant_app/core/erros/failures.dart';
import 'package:smart_assistant_app/core/storage/auc_hive_storage_service.dart';
import 'package:smart_assistant_app/infrastructure/constants/storage_contants.dart';
import 'package:smart_assistant_app/presentation/common/cubit/language/language_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

abstract class CommonLocalDataSource {
  Either<Failure, LocaleLanguage?> getCachedLanguage();
  Either<Failure, Unit> cacheLanguage(LocaleLanguage localeLanguage);
}

@Singleton(as: CommonLocalDataSource)
class CommonLocalDataSourceImpl implements CommonLocalDataSource {
  final MainHiveStorageService storage;

  CommonLocalDataSourceImpl(this.storage);

  @override
  Either<Failure, LocaleLanguage?> getCachedLanguage() {
    try {
      final String? langCode = storage.get(StorageConstants.localeLanguage);
      if (langCode is String) {
        return Right(langCode == LocaleLanguage.ar.name ? LocaleLanguage.ar : LocaleLanguage.en);
      }
      return const Right(null);
    } catch (e) {
      return const Left(Failure.cacheReadFailure());
    }
  }

  @override
  Either<Failure, Unit> cacheLanguage(LocaleLanguage localeLanguage) {
    try {
      storage.set(StorageConstants.localeLanguage, localeLanguage.name);
      return const Right(unit);
    } catch (e) {
      return const Left(Failure.cacheWriteFailure());
    }
  }
}
