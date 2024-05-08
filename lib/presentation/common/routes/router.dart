import 'package:smart_assistant_app/presentation/common/cubit/language/language_cubit.dart';

import 'package:auto_route/auto_route.dart';
import 'package:smart_assistant_app/presentation/features/authentication/sign_in/pages/sign_in_page.dart';
import 'package:smart_assistant_app/presentation/features/authentication/welcome/pages/welcome_page.dart';
import 'package:smart_assistant_app/presentation/features/public/guest_assistance/pages/contact_us_page.dart';
import 'package:smart_assistant_app/presentation/features/public/guest_assistance/pages/faq_page.dart';
import 'package:smart_assistant_app/presentation/features/public/guest_assistance/pages/privacy_policy_page.dart';
import 'package:smart_assistant_app/presentation/features/public/guest_assistance/pages/terms_and_conditions_consent_page.dart';
import 'package:smart_assistant_app/presentation/features/splash_page/splash_page.dart';
import 'package:smart_assistant_app/presentation/features/static/pages/common_widget_page.dart';
import 'package:smart_assistant_app/presentation/features/user_portal/pages/user_account_page.dart';
import 'package:flutter/material.dart';
part 'router.gr.dart';

const int _duration = 300;

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();
  @override
  final List<AutoRoute> routes = [
    CustomRoute(
      path: '/',
      page: SplashRoute.page,
      transitionsBuilder: TransitionsBuilders.fadeIn,
      durationInMilliseconds: _duration,
    ),
    CustomRoute(
      page: CommonWidgetsRoute.page,
      transitionsBuilder: TransitionsBuilders.fadeIn,
      durationInMilliseconds: _duration * 2,
    ),
    CustomRoute(
      page: SignInRoute.page,
      transitionsBuilder: localisedLateralTransition,
      durationInMilliseconds: _duration,
    ),
  ];

  static Widget localisedLateralTransition(context, animation, secondaryAnimation, child) {
    final isRTL = Localizations.localeOf(context).languageCode == LocaleLanguage.ar.name;
    final transitionBuilder =
        isRTL ? TransitionsBuilders.slideRight : TransitionsBuilders.slideLeft;

    return transitionBuilder(context, animation, secondaryAnimation, child);
  }
}
