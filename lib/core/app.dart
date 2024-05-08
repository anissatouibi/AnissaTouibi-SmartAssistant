import 'dart:io';

class AppEnvState {
  AppEnvState._();
  static bool get setProduction => true;

  //Dev
  static const int devIosBackendVersion = 0;
  static const int devAndroidBackendVersion = 0;
  //Prod
  static const int prodIosBackendVersion = 0;
  static const int prodAndroidBackendVersion = 0;
  // dynamic
  static int iosBackendVersion = isProd ? prodIosBackendVersion : devIosBackendVersion;
  static int androidBackendVersion = isProd ? prodAndroidBackendVersion : devAndroidBackendVersion;

  static bool get isAndroid => Platform.isAndroid;
  static bool get isProd => setProduction;

  static String get androidProdVersion => 'Ver 1.0.0';
  static String get iosProdVersion => 'Ver 1.0.0';
  static String get prodVersion => isAndroid ? androidProdVersion : iosProdVersion;
  static String get androidDevVersion => 'SHR 1.0.0';
  static String get iosTFVersion => 'TF 1.0.0';
  static String get devVersion => isAndroid ? androidDevVersion : iosTFVersion;
  static int get currentBackendVersion => isAndroid ? androidBackendVersion : iosBackendVersion;

  static String appUnifiedVersion = "${isProd ? "Stable" : "Internal"}  $currentBackendVersion";
}
