import 'package:smart_assistant_app/core/app.dart';

class ApiConstants {
  static bool isProd = AppEnvState.setProduction;

  static String baseUrl = isProd
      ? "http://user-api.westeurope.cloudapp.azure.com"
      : "https://users-auction.astrolab-agency.com";
  static String webSiteUrl = isProd
      ? "https://auction-website.astrolab-agency.com"
      : "https://auction-website.astrolab-agency.com";
  // static String wsLink = isProd
  //     ? "wss://users-auction.astrolab-agency.com"
  //     : "ws://user-api.westeurope.cloudapp.azure.com";
}
