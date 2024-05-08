import 'package:smart_assistant_app/core/extensions/context_extensions.dart';
import 'package:smart_assistant_app/presentation/common/constants/ui_constants.dart';
import 'package:smart_assistant_app/presentation/common/cubit/bottom_nav_bar/bottom_nav_bar_cubit.dart';
import 'package:smart_assistant_app/presentation/common/cubit/language/language_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slang/builder/utils/string_extensions.dart';

class GeneralUtils {
  static BorderRadius defaultBorderRadius({double? radius}) {
    return BorderRadius.all(Radius.circular(radius ?? UIConstants.defaultBorderRadius));
  }

  static BorderRadius borderRadius15() {
    return const BorderRadius.all(Radius.circular(15));
  }

  static LocaleLanguage getLocaleLanguageFromCode(String code) {
    return code == "en" ? LocaleLanguage.en : LocaleLanguage.ar;
  }

  static String trField(
    BuildContext context, {
    required String textAr,
    required String textEn,
  }) {
    return (context.isArabic ? textAr : textEn).capitalize();
  }
}
