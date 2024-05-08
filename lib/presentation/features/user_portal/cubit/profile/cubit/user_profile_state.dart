part of 'user_profile_cubit.dart';

@freezed
class UserProfileState with _$UserProfileState {
  const factory UserProfileState({
    final MainStatus? mainStatus,
    final UserProfile? currentProfile,
    final UserProfile? profileBeingDeleted,
    final CubitStatus? status,
  }) = _UserProfileState;

  factory UserProfileState.initial() => const UserProfileState();
}
