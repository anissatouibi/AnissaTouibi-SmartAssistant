import 'dart:developer';

import 'package:smart_assistant_app/core/usecases/public/get_public_data.dart';
import 'package:smart_assistant_app/core/usecases/usecase.dart';
import 'package:smart_assistant_app/infrastructure/models/general/cubitStatus.dart';
import 'package:smart_assistant_app/infrastructure/models/general/mainStatus.dart';
import 'package:smart_assistant_app/infrastructure/models/public/public_data_repsonse_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
part 'public_data_state.dart';
part 'public_data_cubit.freezed.dart';

@injectable
class PublicDataCubit extends Cubit<PublicDataState> {
  PublicDataCubit(
    this._getPublicData,
  ) : super(PublicDataState.initial());
  final GetPublicData _getPublicData;
  getInitialPublicFetches() async {
    emit(state.copyWith(mainStatus: MainStatus.loading));
    final result = await _getPublicData(NoParams());
    result.fold((l) {
      emit(state.copyWith(mainStatus: MainStatus.failure));
    }, (data) {
      emit(state.copyWith(mainStatus: MainStatus.loaded, data: data));
    });
  }
}
