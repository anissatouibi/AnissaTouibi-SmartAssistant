import 'package:smart_assistant_app/core/erros/failures.dart';
import 'package:smart_assistant_app/core/usecases/profile/get_user_current_profile.dart';
import 'package:smart_assistant_app/core/usecases/usecase.dart';
import 'package:smart_assistant_app/infrastructure/extensions/failures.dart';
import 'package:smart_assistant_app/infrastructure/models/account/profile_settings.dart';
import 'package:smart_assistant_app/infrastructure/models/account/user_profile.dart';
import 'package:smart_assistant_app/infrastructure/models/general/cubitStatus.dart';
import 'package:smart_assistant_app/infrastructure/models/general/mainStatus.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'user_profile_state.dart';
part 'user_profile_cubit.freezed.dart';

@injectable
class UserProfileCubit extends Cubit<UserProfileState> {
  final GetUserCurrentProfile _getUserCurrentProfile;
  UserProfileCubit(
    this._getUserCurrentProfile,
  ) : super(UserProfileState.initial());
  bool get isCompany => state.currentProfile?.kind == ProfileKind.company;
  bool get isPersonal => state.currentProfile?.type == ProfileType.personal;

  initializeCubitStatus() {
    emit(state.copyWith(status: const CubitStatus(statusType: CubitStatusType.idle)));
  }

  getAccountCurrentProfile({CubitAction? action}) async {
    emit(state.copyWith(mainStatus: MainStatus.loading, status: CubitStatus(action: action)));
    final result = await _getUserCurrentProfile(NoParams());
    result.fold((l) {
      emit(state.copyWith(mainStatus: MainStatus.failure, status: CubitStatus(action: action)));
    }, (currentProfile) {
      emit(state.copyWith(
          mainStatus: MainStatus.loaded,
          currentProfile: currentProfile,
          status: CubitStatus(action: action)));
    });
  }
}
