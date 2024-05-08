import 'dart:async';

import 'package:smart_assistant_app/core/erros/failures.dart';
import 'package:smart_assistant_app/core/extensions/string_extensions.dart';
import 'package:smart_assistant_app/core/network/dio_api_client.dart';
import 'package:smart_assistant_app/infrastructure/constants/api_endpoint_urls.dart';
import 'package:smart_assistant_app/infrastructure/errors/auc_exceptions.dart';
import 'package:smart_assistant_app/infrastructure/errors/gql_error_handler.dart';
import 'package:smart_assistant_app/infrastructure/models/account/user_profile.dart';
import 'package:smart_assistant_app/infrastructure/models/auth/auth_tokens.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

abstract class UserAccountRemoteDataSource {
  /// [Account Profile]
  ///
  /// Get Account Profile
  Future<Either<Failure, List<UserProfile>>> getAccountProfiles();

  /// [Account deletion]
  ///
  /// Delete user account
  Future<Either<Failure, Unit>> deleteAccount(String reason);
}

@Singleton(as: UserAccountRemoteDataSource)
class UserAccountRemoteDataSourceImpl implements UserAccountRemoteDataSource {
  final DioClient client;
  final FlutterSecureStorage storage;

  UserAccountRemoteDataSourceImpl(this.client, this.storage);

  /// [Account Profile]

  @override
  Future<Either<Failure, List<UserProfile>>> getAccountProfiles() async {
    try {
      // final queryParams = {
      //   "perPage": 100,
      // };
      final Response response = await client.dio.get(
        EndpointUrls.getAccountProfiles,
        // queryParameters: queryParams
      );
      var profilesList = List.from(response.data['data']);

      var profiles = profilesList.map((p) => UserProfile.fromJson(p)).toList();

      return Right(profiles);
    } catch (e) {
      return Left(MainExceptions.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteAccount(String reason) async {
    try {
      await client.dio.delete(EndpointUrls.deleteAccount, data: {"delete_reason": reason});
      return const Right(unit);
    } catch (e) {
      return Left(MainExceptions.exceptionToFailure(e));
    }
  }
}
