import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:smart_assistant_app/core/erros/failures.dart';
import 'package:smart_assistant_app/core/network/dio_api_client.dart';
import 'package:smart_assistant_app/infrastructure/constants/api_endpoint_urls.dart';
import 'package:smart_assistant_app/infrastructure/errors/auc_exceptions.dart';
import 'package:smart_assistant_app/infrastructure/models/account/user_profile.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

abstract class UserProfileRemoteDataSource {
  /// [Current Profile]
  ///
  /// Get Current Profile
  Future<Either<Failure, UserProfile>> getCurrentProfile();
}

@Singleton(as: UserProfileRemoteDataSource)
class UserProfileRemoteDataSourceImpl implements UserProfileRemoteDataSource {
  final DioClient client;
  final FlutterSecureStorage storage;

  UserProfileRemoteDataSourceImpl(this.client, this.storage);

  /// [UserProfile Get]
  @override
  Future<Either<Failure, UserProfile>> getCurrentProfile() async {
    try {
      final Response response = await client.dio.get(EndpointUrls.getCurrentProfile);

      return Right(UserProfile.fromJson(response.data));
    } catch (e) {
      return Left(MainExceptions.exceptionToFailure(e));
    }
  }
}
