import 'dart:async';

import 'package:smart_assistant_app/core/debug/app_bloc_observer.dart';
import 'package:smart_assistant_app/injection.dart';
import 'package:smart_assistant_app/presentation/app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();

    unawaited(SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]));

    /// injectable initialization
    await configureDependencies();

    Bloc.observer = AppBlocObserver();

    runApp(const AppProvided());
  }, (e, stackTrace) {
    print(e);
    throw e;
  });
}



















// class MenuScreen extends StatelessWidget {
//   final String title;

//   const MenuScreen({super.key, required this.title});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColor.background200Color,
//       body: SafeArea(
//         child: CustomScrollView(slivers: [
//           const AppBarSliverHomeScreen(),
//           SliverFillRemaining(child: Center(child: Text(title)))
//         ]),
//       ),
//     );
//   }
// }