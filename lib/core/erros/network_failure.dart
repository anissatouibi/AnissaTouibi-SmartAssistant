import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dio/dio.dart';

part 'network_failure.freezed.dart';

@freezed
class NetworkFailure with _$NetworkFailure {
  const factory NetworkFailure.customBackendError(Map error) = CustomBackendError;

  const factory NetworkFailure.requestCancelled() = RequestCancelled;

  const factory NetworkFailure.noDataFound() = NoDataFound;

  const factory NetworkFailure.unauthorisedRequest(String? errorMessage) = UnauthorisedRequest;

  const factory NetworkFailure.badRequest(dynamic error) = BadRequest;

  const factory NetworkFailure.notFound(dynamic error) = NotFound;

  const factory NetworkFailure.methodNotAllowed() = MethodNotAllowed;

  const factory NetworkFailure.notAcceptable() = NotAcceptable;

  const factory NetworkFailure.requestTimeout() = RequestTimeout;

  const factory NetworkFailure.sendTimeout() = SendTimeout;

  const factory NetworkFailure.receiveTimeout() = ReceiveTimeout;

  const factory NetworkFailure.conflict() = Conflict;

  const factory NetworkFailure.internalServerError() = InternalServerError;

  const factory NetworkFailure.notImplemented() = NotImplemented;

  const factory NetworkFailure.serviceUnavailable() = ServiceUnavailable;

  const factory NetworkFailure.connectionRefused() = ConnectionRefused;

  const factory NetworkFailure.noInternetConnection() = NoInternetConnection;

  const factory NetworkFailure.defaultError(String error) = DefaultError;

  const factory NetworkFailure.unknown(dynamic data) = UnknownError;

  static NetworkFailure getDioException(error) {
    late NetworkFailure networkFailure;
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.cancel:
          networkFailure = const NetworkFailure.requestCancelled();
          break;
        case DioExceptionType.connectionTimeout:
          networkFailure = const NetworkFailure.requestTimeout();
          break;
        case DioExceptionType.badCertificate:
          networkFailure = const NetworkFailure.connectionRefused();
          break;
        case DioExceptionType.sendTimeout:
          networkFailure = const NetworkFailure.sendTimeout();
          break;
        case DioExceptionType.receiveTimeout:
          networkFailure = const NetworkFailure.receiveTimeout();
          break;
        case DioExceptionType.connectionError:
          networkFailure = const NetworkFailure.noInternetConnection();
          break;

        case DioExceptionType.unknown:
          networkFailure = NetworkFailure.unknown(error);
          break;

        case DioExceptionType.badResponse:
          final err = error.response?.data;
          if (err != null &&
              err is Map &&
              (err.containsKey('errorCode') || err.containsKey('extensions'))) {
            final error = err.containsKey('extensions') ? err['extensions'] : err;
            networkFailure = NetworkFailure.customBackendError(error);
          } else {
            switch (error.response?.statusCode) {
              case 400:
                networkFailure = NetworkFailure.badRequest(error.response?.data);
                break;
              case 401:
                networkFailure = NetworkFailure.unauthorisedRequest(error.response?.data);
                break;
              case 403:
                networkFailure = NetworkFailure.unauthorisedRequest(error.response?.data);
                break;
              case 404:
                networkFailure = NetworkFailure.notFound(error);
                break;
              case 409:
                networkFailure = const NetworkFailure.conflict();
                break;
              case 408:
                networkFailure = const NetworkFailure.requestTimeout();
                break;
              case 500:
                networkFailure = const NetworkFailure.internalServerError();
                break;
              case 503:
                networkFailure = const NetworkFailure.serviceUnavailable();
                break;
              default:
                int? responseCode = error.response?.statusCode;
                networkFailure =
                    NetworkFailure.defaultError("Received invalid status code: $responseCode");
            }
          }
          break;
      }
    } else if (error is SocketException) {
      networkFailure = const NetworkFailure.noInternetConnection();
    } else {
      networkFailure = NetworkFailure.unknown(error);
    }
    return networkFailure;
  }
}
