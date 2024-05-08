import 'package:smart_assistant_app/core/erros/network_failure.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

@freezed
class Failure<T> with _$Failure<T> {
  /// General Failures
  const factory Failure.networkFailure(NetworkFailure f) = _NetworkFailure;
  const factory Failure.platformFailure({String? message}) = PlatformFailure;
  const factory Failure.formatExceptionFailure() = FormatExceptionFailure;
  const factory Failure.unableToProcess(dynamic error) = UnableToProcess;
  const factory Failure.unexpectedError(dynamic data) = UnexpectedError;
  const factory Failure.accessTokenFailure() = AccessTokenFailure;
  const factory Failure.cacheReadFailure() = CacheReadFailure;
  const factory Failure.cacheWriteFailure() = CacheWriteFailure;
  const factory Failure.deepLinkFailure(String? message) = DeepLinkFailure;
}
