import 'package:smart_assistant_app/core/dtos/phone_sign_in_params_dto.dart';
import 'package:smart_assistant_app/core/erros/failures.dart';
import 'package:smart_assistant_app/core/network/dio_api_client.dart';
import 'package:smart_assistant_app/infrastructure/constants/api_endpoint_urls.dart';
import 'package:smart_assistant_app/infrastructure/errors/auc_exceptions.dart';
import 'package:smart_assistant_app/infrastructure/models/auth/auth_tokens.dart';
import 'package:smart_assistant_app/presentation/common/constants/general_constants.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

abstract class AuthenticationRemoteDataSource {
  Future<Either<Failure, AuthTokens>> phoneSignIn({required PhoneSignInParamsDto dto});

  Future<Either<Failure, Unit>> checkTokenValidity();

  Future<Either<Failure, Unit>> logOut({required AuthTokens dto});

  Future<Either<Failure, AuthTokens>> refreshAuthTokens({required AuthTokens dto});
}

@Singleton(as: AuthenticationRemoteDataSource)
class AuthenticationRemoteDataSourceImpl implements AuthenticationRemoteDataSource {
  final DioClient client;

  AuthenticationRemoteDataSourceImpl(this.client);
  @override
  Future<Either<Failure, Unit>> checkTokenValidity() async {
    try {
      await client.dio.get(EndpointUrls.getCurrentProfile);
      return const Right(unit);
    } catch (e) {
      return Left(MainExceptions.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, AuthTokens>> phoneSignIn({required PhoneSignInParamsDto dto}) async {
    try {
      final data = {"phone": dto.phone, "password": dto.password};

      final Response response = await client.dio.post(EndpointUrls.phoneLogin, data: data);

      Map<String, dynamic> responseMap = response.data;
      var res = AuthTokens.fromJson(responseMap);

      return Right(res);
    } catch (e) {
      return Left(MainExceptions.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, AuthTokens>> refreshAuthTokens({required AuthTokens dto}) async {
    try {
      final Response response = await client.dio
          .post(EndpointUrls.refreshTokens, data: {"refresh_token": dto.refreshToken});
      return Right(AuthTokens.fromJson(response.data));
    } catch (e) {
      return Left(MainExceptions.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> logOut({required AuthTokens dto}) async {
    try {
      await client.dio.post(EndpointUrls.logout, data: {"refresh_token": dto.refreshToken});
      return const Right(unit);
    } catch (e) {
      return Left(MainExceptions.exceptionToFailure(e));
    }
  }
}
