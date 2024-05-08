import 'package:smart_assistant_app/presentation/common/cubit/language/language_cubit.dart';
import 'package:flutter/cupertino.dart';

extension ScreenExtension on BuildContext {
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  bool get isArabic => Localizations.localeOf(this).languageCode == LocaleLanguage.ar.name;
}
