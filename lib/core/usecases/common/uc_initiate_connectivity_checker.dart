import 'package:smart_assistant_app/core/erros/failures.dart';
import 'package:smart_assistant_app/core/usecases/usecase.dart';
import 'package:smart_assistant_app/infrastructure/datasources/remote_datasources/common_remote_data_source.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@singleton
class InitiateConnectivityChecker implements UsecaseStream<bool, NoParams> {
  final CommonRemoteDataSource repository;

  InitiateConnectivityChecker(this.repository);

  @override
  Stream<Either<Failure, bool>> call(NoParams _) {
    return repository.connectivityCheck();
  }
}
