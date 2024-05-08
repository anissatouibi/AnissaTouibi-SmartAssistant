import 'dart:io';

import 'package:smart_assistant_app/core/storage/auc_hive_storage_service.dart';

import 'package:dio/dio.dart';
import 'package:smart_assistant_app/presentation/features/bottom_nav_layout_manager.dart/widgets/BottomNavLayoutResources/page_stack.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

const _checkDuration = Duration(seconds: 5);

@module
abstract class ExternalLibraryInjectableModule {
  @lazySingleton
  Dio get dio => Dio();

  @lazySingleton
  FlutterSecureStorage get prefs => const FlutterSecureStorage();

  @lazySingleton
  InternetConnectionChecker get connectionChecker => InternetConnectionChecker.createInstance(
        addresses: [
          AddressCheckOptions(
            address: InternetAddress(
              '8.8.4.4', // Google
              type: InternetAddressType.IPv4,
            ),
          ),
        ],
        checkTimeout: _checkDuration,
        checkInterval: _checkDuration,
      );

  @lazySingleton
  ReorderToFrontPageStack get bottomNavPageStack => ReorderToFrontPageStack(initialPage: 0);

  @preResolve
  @lazySingleton
  Future<MainHiveStorageService> get openBox async {
    await Hive.initFlutter();
    final MainHiveStorageService initializedStorageService = MainHiveStorageService();
    await initializedStorageService.init();
    return initializedStorageService;
  }
}
