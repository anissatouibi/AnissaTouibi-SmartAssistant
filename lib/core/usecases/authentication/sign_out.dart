import 'package:smart_assistant_app/core/erros/failures.dart';
import 'package:smart_assistant_app/core/extensions/dartz.dart';
import 'package:smart_assistant_app/core/usecases/usecase.dart';
import 'package:smart_assistant_app/infrastructure/datasources/local_datasources/auth_local_data_source.dart';
import 'package:smart_assistant_app/infrastructure/repositories/auth_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@singleton
class SignOut implements Usecase<Unit, NoParams> {
  final IAuthRepository repository;
  final AuthenticationLocalDataSource localDataSource;
  const SignOut(this.repository, this.localDataSource);

  @override
  Future<Either<Failure, Unit>> call(NoParams params) async {
    //get refresh token
    final tokens = await localDataSource.getCachedAuth();
    if (tokens.isLeft()) return Left(tokens.asLeft());

    // attempt remote logout
    final remoteResult = await repository.logOut(dto: tokens.asRight());
    if (remoteResult.isLeft()) return Left(remoteResult.asLeft());

    /// clear cache if signOut succeeds
    final cacheResult = await localDataSource.clearAuthCache();
    if (cacheResult.isLeft()) return Left(cacheResult.asLeft());
    return const Right(unit);
  }
}
