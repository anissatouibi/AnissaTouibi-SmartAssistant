import 'package:smart_assistant_app/core/erros/failures.dart';
import 'package:smart_assistant_app/core/erros/network_failure.dart';
import 'package:smart_assistant_app/core/extensions/dartz.dart';
import 'package:smart_assistant_app/core/network/i_network_info.dart';
import 'package:smart_assistant_app/infrastructure/constants/api_endpoint_urls.dart';
import 'package:smart_assistant_app/infrastructure/datasources/local_datasources/auth_local_data_source.dart';
import 'package:smart_assistant_app/infrastructure/datasources/remote_datasources/authentication_remote_data_source.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'api_constants.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:injectable/injectable.dart';

const _connectionTimeoutDuration = Duration(seconds: 30);

/// will bypass accessToken check on these urls
const noneAuthedRestRoutes = [
  EndpointUrls.mobileAppSettings,
  EndpointUrls.phoneLogin,
  EndpointUrls.getFaqs,
  EndpointUrls.getTermsAndConditions,
  EndpointUrls.getPrivacyPolicies,
  EndpointUrls.sendContactUs,
  EndpointUrls.individualSignup,
  EndpointUrls.phoneLogin,
  EndpointUrls.getAucMainCategories,
  EndpointUrls.getAuctions,
];

@injectable
class DioClient {
  final Dio dio;
  final INetworkInfo networkInfo;
  final AuthenticationLocalDataSource _authenticationLocalDataSource;
  // final AuthenticationRemoteDataSource _authenticationRemoteDataSource;
  DioClient(
    this.dio,
    this._authenticationLocalDataSource,
    this.networkInfo,
    // this._authenticationRemoteDataSource
  ) {
    BaseOptions options = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
    );
    options.connectTimeout = _connectionTimeoutDuration;
    options.receiveTimeout = _connectionTimeoutDuration;

    dio.options = options;
    dio.interceptors.add(PrettyDioLogger());
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) async {
        print("request body = ${options.data}");
        options.headers['Accept'] = 'application/json';
        options.headers['Content-Type'] = 'application/json';
        if (await networkInfo.isConnected) {
          final isRefreshingAlready = options.path == EndpointUrls.refreshTokens;

          final mustHaveAuthRest = options.path == "/graphql"
              ? false
              : !noneAuthedRestRoutes.any((x) => options.path.contains(x));

          if ((mustHaveAuthRest) && !isRefreshingAlready) {
            var cachedAuthEither = await _authenticationLocalDataSource.getCachedAuth();

            if (cachedAuthEither.isRight()) {
              var cachedToken = cachedAuthEither.asRight();
              if (JwtDecoder.isExpired(cachedToken.accessToken)) {
                var error = const Failure.accessTokenFailure();
                final authenticationRemoteDataSource = AuthenticationRemoteDataSourceImpl(
                    this); // not to create cyclic injection of DioClient inside of AuthenticationRemoteDataSourceImpl
                final refreshEither =
                    await authenticationRemoteDataSource.refreshAuthTokens(dto: cachedToken);
                if (refreshEither.isLeft()) {
                  error = refreshEither.asLeft();
                  _authenticationLocalDataSource.clearAuthCache();
                } else {
                  _authenticationLocalDataSource.cacheAuth(refreshEither.asRight());
                  return handler.next(options);
                }
                return handler.reject(
                  DioException(
                      requestOptions: options, type: DioExceptionType.unknown, error: error),
                  true,
                );
              }
              options.headers['Authorization'] = 'Bearer ${cachedToken.accessToken}';
              print("headers = ${options.headers} ");
            }
          }

          return handler.next(options);
        } else {
          // No internet
          return handler.reject(
              DioException(
                  requestOptions: options,
                  type: DioExceptionType.connectionError,
                  error: const Failure.networkFailure(NetworkFailure.noInternetConnection())),
              true);
        }
      },
      onResponse: (Response response, ResponseInterceptorHandler responseInterceptorHandler) {
        return responseInterceptorHandler.next(response);
      },
      onError: (DioException e, ErrorInterceptorHandler errorInterceptorHandler) async {
        return errorInterceptorHandler.next(e);
      },
    ));
  }
}
