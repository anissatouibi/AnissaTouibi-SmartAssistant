import 'package:freezed_annotation/freezed_annotation.dart';

part 'phone_sign_in_params_dto.freezed.dart';
part 'phone_sign_in_params_dto.g.dart';

@freezed
class PhoneSignInParamsDto with _$PhoneSignInParamsDto {
  const factory PhoneSignInParamsDto({
    required String phone,
    required String password,
  }) = _PhoneSignInParamsDto;
  factory PhoneSignInParamsDto.fromJson(Map<String, dynamic> json) =>
      _$PhoneSignInParamsDtoFromJson(json);
}
