import 'package:smart_assistant_app/presentation/common/routes/router.dart';
import 'package:injectable/injectable.dart';

@module
abstract class RoutesInjectableModule {
  @lazySingleton
  AppRouter get appRouter => AppRouter();
}
