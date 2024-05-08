import 'package:smart_assistant_app/core/erros/failures.dart';
import 'package:smart_assistant_app/infrastructure/models/general/app_settings.dart';
import 'package:smart_assistant_app/infrastructure/repositories/common_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:smart_assistant_app/core/usecases/usecase.dart';
import 'package:injectable/injectable.dart';

@singleton
class GetAppSettings implements Usecase<AppSettings, NoParams> {
  final ICommonRepository repository;

  GetAppSettings(this.repository);

  @override
  Future<Either<Failure, AppSettings>> call(NoParams _) async {
    return await repository.getAppSettingsData();
  }
}
