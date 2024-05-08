import 'package:smart_assistant_app/core/erros/failures.dart';
import 'package:smart_assistant_app/core/erros/network_failure.dart';
import 'package:smart_assistant_app/i18n/strings.g.dart';
import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auc_exceptions.freezed.dart';

@freezed
class MainExceptions with _$MainExceptions {
  const MainExceptions._();

  const factory MainExceptions() = _MainExceptions;

  static Failure exceptionToFailure(error) {
    if (error is PlatformException) {
      return Failure.platformFailure(message: t.errors.failures.platformError);
    } else if (error is Exception) {
      try {
        return Failure.networkFailure(NetworkFailure.getDioException(error));
      } on FormatException catch (_) {
        return const Failure.formatExceptionFailure();
      } catch (_) {
        return Failure.unexpectedError(error);
      }
    } else {
      if (error.toString().contains("is not a subtype of")) {
        return Failure.unableToProcess(error);
      } else {
        return Failure.networkFailure(NetworkFailure.getDioException(error));
      }
    }
  }
}
