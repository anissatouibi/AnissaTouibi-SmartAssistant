part of 'public_data_cubit.dart';

@freezed
class PublicDataState with _$PublicDataState {
  const factory PublicDataState({
    final MainStatus? mainStatus,
    final PublicDataResponseModel? data,
    final CubitStatus? status,
  }) = _PublicDataState;

  factory PublicDataState.initial() => const PublicDataState();
}
