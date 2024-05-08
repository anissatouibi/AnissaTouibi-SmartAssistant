import 'package:smart_assistant_app/core/erros/failures.dart';
import 'package:smart_assistant_app/infrastructure/datasources/remote_datasources/common_remote_data_source.dart';
import 'package:smart_assistant_app/infrastructure/models/general/app_settings.dart';
import 'package:smart_assistant_app/infrastructure/models/public/faq.dart';
import 'package:smart_assistant_app/infrastructure/models/public/privacy_policy.dart';
import 'package:smart_assistant_app/infrastructure/models/public/term_and_condition.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

abstract class ICommonRepository {
  /// Mobile App Settings
  Future<Either<Failure, AppSettings>> getAppSettingsData();
}

@Singleton(as: ICommonRepository)
class CommonRepositoryImpl implements ICommonRepository {
  final CommonRemoteDataSource remoteDataSource;

  const CommonRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, AppSettings>> getAppSettingsData() {
    return remoteDataSource.getAppSettingsData();
  }
}
