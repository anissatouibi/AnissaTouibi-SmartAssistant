import 'package:smart_assistant_app/core/erros/failures.dart';
import 'package:smart_assistant_app/infrastructure/constants/storage_contants.dart';
import 'package:smart_assistant_app/infrastructure/models/auth/auth_tokens.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

abstract class AuthenticationLocalDataSource {
  /// Returns saved [Tokens] object
  Future<Either<Failure, AuthTokens>> getCachedAuth();

  /// Save tokens to device
  /// Required [Tokens] object containing [token] (access token) and [refreshToken] (refresh token) values
  Future<Either<Failure, Unit>> cacheAuth(AuthTokens tokens);

  /// Delete tokens from device
  Future<Either<Failure, Unit>> clearAuthCache();
}

@Singleton(as: AuthenticationLocalDataSource)
class AuthenticationLocalDataSourceImpl implements AuthenticationLocalDataSource {
  final FlutterSecureStorage storage;

  AuthenticationLocalDataSourceImpl(this.storage);

  @override
  Future<Either<Failure, AuthTokens>> getCachedAuth() async {
    try {
      var tokens = await Future.wait([
        storage.read(key: StorageConstants.accessToken),
        storage.read(key: StorageConstants.refreshToken),
      ]);
      if (tokens[0] is String && tokens[1] is String) {
        return Right(AuthTokens(accessToken: tokens[0]!, refreshToken: tokens[1]!));
      }
      return const Left(Failure.accessTokenFailure());
    } catch (e) {
      return const Left(Failure.accessTokenFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> cacheAuth(AuthTokens tokens) async {
    try {
      await Future.wait([
        storage.write(key: StorageConstants.accessToken, value: tokens.accessToken),
        storage.write(key: StorageConstants.refreshToken, value: tokens.refreshToken),
      ]);
      return const Right(unit);
    } catch (e) {
      return const Left(Failure.accessTokenFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> clearAuthCache() async {
    try {
      await Future.wait([
        storage.delete(key: StorageConstants.accessToken),
        storage.delete(key: StorageConstants.refreshToken),
      ]);
      return const Right(unit);
    } catch (e) {
      return const Left(Failure.accessTokenFailure());
    }
  }
}
