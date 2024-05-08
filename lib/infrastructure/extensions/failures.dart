import 'package:smart_assistant_app/core/erros/failures.dart';
import 'package:smart_assistant_app/i18n/strings.g.dart';
import 'package:smart_assistant_app/infrastructure/errors/customErrorFrontMapper.dart';

extension FailuresMapper on Failure {
  String getMessage() {
    Failure a = this;
    return a.map(
      networkFailure: (f) {
        return f.f.maybeMap(
          unauthorisedRequest: (nf) => nf.errorMessage ?? t.errors.failures.networkFailure,
          noInternetConnection: (nf) => t.errors.failures.connectionError,
          customBackendError: (customError) {
            return CustomErrorFrontMapper.getCustomBackendMappedTranslatedMessage(
                customError.error);
          },

          notFound: (f) {
            return t.errors.failures.notFound;
          },
          requestTimeout: (nf) => t.errors.failures.requestTimeout,
          sendTimeout: (nf) => t.errors.failures.requestTimeout,
          receiveTimeout: (nf) => t.errors.failures.requestTimeout,

          orElse: () {
            return t.errors.failures.networkFailure;
          },
          // TODO - map rest of the error messages
        );
      },
      formatExceptionFailure: (_) => t.errors.failures.formatException,
      unableToProcess: (_) => t.errors.failures.unableToProcess,
      platformFailure: (_) => t.errors.failures.platformError,
      unexpectedError: (f) {
        return t.errors.failures.unexpectedError;
      },
      accessTokenFailure: (_) => t.errors.failures.accessTokenFailure,
      cacheReadFailure: (_) => t.errors.failures.cacheReadFailure,
      cacheWriteFailure: (_) => t.errors.failures.cacheWriteFailure,
      deepLinkFailure: (_) => t.errors.failures.deepLinkFailure,
    );
  }
}
