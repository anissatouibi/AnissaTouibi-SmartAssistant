import 'package:bloc/bloc.dart';
import 'package:smart_assistant_app/core/dtos/phone_sign_in_params_dto.dart';
import 'package:smart_assistant_app/core/usecases/authentication/phone_sign_in.dart';
import 'package:smart_assistant_app/infrastructure/extensions/failures.dart';
import 'package:smart_assistant_app/infrastructure/models/general/cubitStatus.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'login_state.dart';
part 'login_cubit.freezed.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final PhoneSignIn _phoneLogin;
  LoginCubit(this._phoneLogin) : super(LoginState.initial());

  signInPressed({required String phone, required String password}) async {
    emit(state.copyWith(
        status: const CubitStatus(statusType: CubitStatusType.loading, action: CubitAction.none)));
    final result = await _phoneLogin(PhoneSignInParamsDto(
      phone: phone,
      password: password,
    ));

    //fold result
    return result.fold((l) {
      emit(state.copyWith(
          status: CubitStatus(
              statusType: CubitStatusType.failure,
              action: CubitAction.phoneSignIn,
              errorMsg: l.getMessage())));
    }, (r) {
      emit(state.copyWith(
          status: const CubitStatus(
              statusType: CubitStatusType.success, action: CubitAction.phoneSignIn)));
    });
  }
}
