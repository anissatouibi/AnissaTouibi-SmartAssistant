import 'package:smart_assistant_app/core/dtos/phone_sign_in_params_dto.dart';
import 'package:smart_assistant_app/core/erros/failures.dart';
import 'package:smart_assistant_app/infrastructure/datasources/remote_datasources/authentication_remote_data_source.dart';
import 'package:smart_assistant_app/infrastructure/models/auth/auth_tokens.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

abstract class IAuthRepository {
  /// Check whether the current ACCESS token is valid
  Future<Either<Failure, Unit>> checkTokenValidity();

  /// Get AuthToken from REFRESH token
  Future<Either<Failure, AuthTokens>> refreshAuthTokens({required AuthTokens dto});

  /// Get AuthToken from REFRESH token
  Future<Either<Failure, Unit>> logOut({required AuthTokens dto});

  /// Sign in an user
  Future<Either<Failure, AuthTokens>> phoneSignIn({required PhoneSignInParamsDto dto});
}

@Singleton(as: IAuthRepository)
class AuthRepositoryImpl implements IAuthRepository {
  final AuthenticationRemoteDataSource remoteDataSource;

  const AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, AuthTokens>> phoneSignIn({required PhoneSignInParamsDto dto}) {
    return remoteDataSource.phoneSignIn(dto: dto);
  }

  @override
  Future<Either<Failure, Unit>> checkTokenValidity() {
    return remoteDataSource.checkTokenValidity();
  }

  @override
  Future<Either<Failure, AuthTokens>> refreshAuthTokens({required AuthTokens dto}) {
    return remoteDataSource.refreshAuthTokens(dto: dto);
  }

  @override
  Future<Either<Failure, Unit>> logOut({required AuthTokens dto}) {
    return remoteDataSource.logOut(dto: dto);
  }
}
