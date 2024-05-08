part of 'auth_cubit.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = Initial;
  const factory AuthState.checking() = Checking;
  const factory AuthState.canceled() = Canceled;
  const factory AuthState.authenticated() = Authenticated;
  const factory AuthState.unauthenticated({String? errorMessage}) = Unauthenticated;
}
