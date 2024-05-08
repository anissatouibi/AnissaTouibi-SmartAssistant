import 'package:smart_assistant_app/core/dtos/phone_sign_in_params_dto.dart';
import 'package:smart_assistant_app/core/erros/failures.dart';
import 'package:smart_assistant_app/core/extensions/dartz.dart';
import 'package:smart_assistant_app/core/usecases/usecase.dart';
import 'package:smart_assistant_app/infrastructure/datasources/local_datasources/auth_local_data_source.dart';
import 'package:smart_assistant_app/infrastructure/models/auth/auth_tokens.dart';
import 'package:smart_assistant_app/infrastructure/repositories/auth_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@singleton
class PhoneSignIn implements Usecase<AuthTokens, PhoneSignInParamsDto> {
  final IAuthRepository repository;
  final AuthenticationLocalDataSource localDataSource;
  const PhoneSignIn(this.repository, this.localDataSource);

  @override
  Future<Either<Failure, AuthTokens>> call(PhoneSignInParamsDto params) async {
    final remoteResult = await repository.phoneSignIn(dto: params);
    if (remoteResult.isLeft()) return Left(remoteResult.asLeft());
    final authTokens = remoteResult.asRight();

    /// save cache if logIn succeeds
    final cacheResult = await localDataSource.cacheAuth(authTokens);
    if (cacheResult.isLeft()) return Left(cacheResult.asLeft());
    return Right(remoteResult.asRight());
  }
}
