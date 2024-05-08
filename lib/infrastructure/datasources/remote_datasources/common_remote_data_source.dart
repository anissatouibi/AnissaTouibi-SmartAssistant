import 'dart:async';
import 'package:smart_assistant_app/core/erros/failures.dart';
import 'package:smart_assistant_app/core/network/dio_api_client.dart';
import 'package:smart_assistant_app/core/network/i_network_info.dart';
import 'package:smart_assistant_app/infrastructure/constants/api_endpoint_urls.dart';
import 'package:smart_assistant_app/infrastructure/errors/auc_exceptions.dart';
import 'package:smart_assistant_app/infrastructure/models/general/app_settings.dart';
import 'package:smart_assistant_app/infrastructure/models/public/faq.dart';
import 'package:smart_assistant_app/infrastructure/models/public/privacy_policy.dart';
import 'package:smart_assistant_app/infrastructure/models/public/term_and_condition.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class CommonRemoteDataSource {
  /// Mobile App Settings

  Future<Either<Failure, AppSettings>> getAppSettingsData();
  // connectivity stream
  Stream<Either<Failure, bool>> connectivityCheck();
}

@Singleton(as: CommonRemoteDataSource)
class CommonRemoteDataSourceImpl implements CommonRemoteDataSource {
  final DioClient client;
  final INetworkInfo networkInfo;

  CommonRemoteDataSourceImpl(this.client, this.networkInfo);
  @override
  Future<Either<Failure, AppSettings>> getAppSettingsData() async {
    try {
      final Response response = await client.dio.get(EndpointUrls.mobileAppSettings);
      var data = Map<String, dynamic>.from(response.data);
      return Right(AppSettings.fromJson(data));
    } catch (e) {
      return Left(MainExceptions.exceptionToFailure(e));
    }
  }

  @override
  Stream<Either<Failure, bool>> connectivityCheck() async* {
    var controller = StreamController<Either<Failure, bool>>();
    var stream = controller.stream;
    networkInfo.connectionSteam.call((status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          controller.add(const Right(true));
          break;
        case InternetConnectionStatus.disconnected:
          controller.add(const Right(false));
          break;
      }
    });
    yield* stream;
  }
}
