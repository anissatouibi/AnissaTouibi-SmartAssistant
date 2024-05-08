import 'dart:async';

import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class INetworkInfo {
  Future<bool> get isConnected;
  StreamSubscription<InternetConnectionStatus> Function(void Function(InternetConnectionStatus)?,
      {bool? cancelOnError, void Function()? onDone, Function? onError}) get connectionSteam;
}
