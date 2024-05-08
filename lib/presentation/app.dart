import 'package:smart_assistant_app/i18n/strings.g.dart';
import 'package:smart_assistant_app/injection.dart';
import 'package:smart_assistant_app/presentation/common/cubit/auth/auth_cubit.dart';
import 'package:smart_assistant_app/presentation/common/cubit/bottom_nav_bar/bottom_nav_bar_cubit.dart';
import 'package:smart_assistant_app/presentation/common/cubit/language/language_cubit.dart';
import 'package:smart_assistant_app/presentation/common/routes/router.dart';
import 'package:smart_assistant_app/presentation/common/theme/app_theme_data.dart';
import 'package:smart_assistant_app/presentation/common/widgets/scroll_behaviors/scroll_glow_indicator_disabler.dart';
import 'package:smart_assistant_app/presentation/features/internet_connectivity_checker/cubit/internet_connectivity_cubit.dart';
import 'package:smart_assistant_app/presentation/features/public/cubit/public_data_cubit.dart';
import 'package:smart_assistant_app/presentation/features/user_portal/cubit/profile/cubit/user_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AppProvided extends StatelessWidget {
  const AppProvided({super.key});

  @override
  Widget build(BuildContext context) {
    return TranslationProvider(
      child: MultiBlocProvider(
        providers: [
          BlocProvider<LanguageCubit>(create: (context) => getIt<LanguageCubit>()..setLanguage()),
          BlocProvider(create: (context) => getIt<InternetConnectivityCubit>()),
          BlocProvider(create: (context) => getIt<AuthCubit>()),
          BlocProvider(create: (context) => getIt<UserProfileCubit>()),
          BlocProvider(create: (context) => getIt<PublicDataCubit>()),
          BlocProvider(create: (context) => getIt<BottomNavbarCubit>()),
        ],
        child: const AuctionApp(),
      ),
    );
  }
}

class AuctionApp extends StatelessWidget {
  const AuctionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, LocaleLanguage>(
      builder: (context, localLang) {
        return ScreenUtilInit(
          designSize: const Size(375, 812),
          useInheritedMediaQuery: true,
          minTextAdapt: true,
          builder: (context, _) => MaterialApp.router(
            routerConfig: getIt<AppRouter>().config(),
            debugShowCheckedModeBanner: false,
            title: 'Smart Assistant',
            builder: (context, child) {
              return ScrollConfiguration(behavior: NoGlowBehavior(), child: child!);
            },
            theme: AppThemeData.getAppThemeData(language: localLang, context: context),
            locale: TranslationProvider.of(context).flutterLocale,
            supportedLocales: AppLocaleUtils.supportedLocales,
            localizationsDelegates: GlobalMaterialLocalizations.delegates,
          ),
        );
      },
    );
  }
}

class MenuScreen extends StatelessWidget {
  final String title;
  const MenuScreen({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(slivers: [SliverFillRemaining(child: Center(child: Text(title)))]),
      ),
    );
  }
}
