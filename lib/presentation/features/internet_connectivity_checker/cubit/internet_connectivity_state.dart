part of 'internet_connectivity_cubit.dart';

@freezed
class InternetConnectivityState with _$InternetConnectivityState {
  const factory InternetConnectivityState.initial() = Initial;
  const factory InternetConnectivityState.processing() = Processing;
  const factory InternetConnectivityState.connected() = Connected;
  const factory InternetConnectivityState.disConnected() = DisConnected;
}
