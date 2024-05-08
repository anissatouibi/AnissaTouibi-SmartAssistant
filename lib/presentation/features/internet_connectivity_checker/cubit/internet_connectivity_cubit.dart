import 'package:smart_assistant_app/core/extensions/dartz.dart';
import 'package:smart_assistant_app/core/network/i_network_info.dart';
import 'package:smart_assistant_app/core/usecases/common/uc_initiate_connectivity_checker.dart';
import 'package:smart_assistant_app/core/usecases/usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
part 'internet_connectivity_state.dart';
part 'internet_connectivity_cubit.freezed.dart';

@injectable
class InternetConnectivityCubit extends Cubit<InternetConnectivityState> {
  final InitiateConnectivityChecker _initiateConnectivityChecker;
  final INetworkInfo networkInfo;
  InternetConnectivityCubit(this._initiateConnectivityChecker, this.networkInfo)
      : super(const InternetConnectivityState.initial());

  void oneTimeChecker() async {
    print('checking cnx---');
    emit(const Processing());
    final isConnected = await networkInfo.isConnected;
    return isConnected ? emit(const Connected()) : emit(const DisConnected());
  }

  void initiateListener() {
    _initiateConnectivityChecker(NoParams()).listen((either) {
      if (either.isLeft()) {
        emit(const Processing());
        return emit(const DisConnected());
      }
      final isConnected = either.asRight();
      print('Connectivity Checker ${isConnected ? 'CONNECTED' : 'DISCONNECTED'}');
      emit(const Processing());
      return isConnected ? emit(const Connected()) : emit(const DisConnected());
    });
  }

  reset() {
    emit(const InternetConnectivityState.initial());
  }
}
