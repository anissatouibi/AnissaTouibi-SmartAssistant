part of 'login_cubit.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    final CubitStatus? status,
  }) = _LoginState;

  factory LoginState.initial() => const LoginState();
}
