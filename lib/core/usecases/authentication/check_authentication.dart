import 'package:smart_assistant_app/core/erros/failures.dart';
import 'package:smart_assistant_app/core/extensions/dartz.dart';
import 'package:smart_assistant_app/core/usecases/usecase.dart';
import 'package:smart_assistant_app/infrastructure/datasources/local_datasources/auth_local_data_source.dart';
import 'package:smart_assistant_app/infrastructure/repositories/auth_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@singleton
class CheckAuthentication implements Usecase<Unit, NoParams> {
  final IAuthRepository repository;
  final AuthenticationLocalDataSource localDataSource;
  CheckAuthentication(this.repository, this.localDataSource);

  @override
  Future<Either<Failure, Unit>> call(NoParams noParams) async {
    final tokens = await localDataSource.getCachedAuth();
    if (tokens.isLeft()) return Left(tokens.asLeft());
    return repository.checkTokenValidity();
  }
}
