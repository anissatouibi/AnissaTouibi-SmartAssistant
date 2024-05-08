import 'dart:async';

import 'package:smart_assistant_app/core/erros/failures.dart';
import 'package:smart_assistant_app/core/usecases/authentication/check_authentication.dart';
import 'package:smart_assistant_app/core/usecases/authentication/sign_out.dart';
import 'package:smart_assistant_app/core/usecases/usecase.dart';
import 'package:smart_assistant_app/infrastructure/extensions/failures.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  final CheckAuthentication _checkAuthentication;
  final SignOut _signOut;

  AuthCubit(this._checkAuthentication, this._signOut) : super(const AuthState.initial());

  requestAuthCheck() async {
    emit(const Checking());
    Either<Failure, Unit> result = await _checkAuthentication(NoParams());
    return result.fold((l) {
      emit(Unauthenticated(errorMessage: l.getMessage()));
    }, (r) {
      emit(const Authenticated());
    });
  }

  // TODO Maybe add a param for manual/intentional logout or forced/auto
  logOut() async {
    emit(const Checking());

    unawaited(_signOut(NoParams()));

    emit(Unauthenticated(errorMessage: const Failure.unexpectedError('').getMessage()));
  }
}
