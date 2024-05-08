import 'package:smart_assistant_app/presentation/common/cubit/language/language_cubit.dart';
import 'package:smart_assistant_app/presentation/common/theme/app_buttons_theme.dart';
import 'package:smart_assistant_app/presentation/common/utils/general_utils.dart';
import 'package:smart_assistant_app/presentation/common/widgets/buttons/auc_text_button.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

class AppThemeData {
  const AppThemeData._();
  static ThemeData getAppThemeData(
      {required LocaleLanguage language, required BuildContext context}) {
    bool isDarkMode = false;
    bool isArabic = language == LocaleLanguage.ar;
    final dynamicBgColor = isDarkMode ? AppColors.blackColor : AppColors.primaryGreyA7Color;
    final dynamicTextColor = isDarkMode ? AppColors.whiteColor : AppColors.blackColor;
    final dynamicCardColor = isDarkMode ? AppColors.primaryBlackishColor : AppColors.whiteColor;
    // final focusedDecorationBorder = OutlineInputBorder(
    //   borderSide: const BorderSide(color: AppColors.whiteColor, width: 1),
    //   borderRadius: GeneralUtils.defaultBorderRadius(),
    // );
    final inputDecorationBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.whiteColor, width: 0),
      borderRadius: GeneralUtils.defaultBorderRadius(),
    );
    final dynamicThemeData = ThemeData(
      textTheme: TextStylesManager.getAppTextTheme(isArabic: isArabic, isDarkMode: isDarkMode),
      scaffoldBackgroundColor: dynamicBgColor,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      disabledColor: AppColors.greyDarkCEColor,
      appBarTheme: AppBarTheme(
        backgroundColor: dynamicCardColor,
      ),
      drawerTheme: const DrawerThemeData(backgroundColor: AppColors.primaryRed8AColor),
      colorScheme: ColorScheme.fromSwatch(
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        backgroundColor: dynamicBgColor,
        cardColor: dynamicCardColor,
      ).copyWith(
        primary: isDarkMode ? AppColors.ramliColor : AppColors.ramliColor,
        onPrimary: isDarkMode ? AppColors.ramliColor : AppColors.ramliColor,
        secondary: isDarkMode ? AppColors.primaryRed8AColor : AppColors.primaryRed8AColor,
        onSecondary: isDarkMode ? AppColors.primaryRed8AColor : AppColors.primaryRed8AColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: AppTextStyles.px12wRegular(context).copyWith(color: dynamicTextColor),
        fillColor: AppColors.whiteColor,
        focusColor: AppColors.whiteColor,
        focusedBorder: inputDecorationBorder,
        enabledBorder: inputDecorationBorder,
        errorBorder: inputDecorationBorder,
        border: inputDecorationBorder,
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: dynamicTextColor,
        selectionHandleColor: AppColors.ramliColor,
        selectionColor: AppColors.ramliColor,
      ),
      textButtonTheme: TextButtonThemeData(
          style: AppButtonsTheme.getMainMainTextButtonTheme(type: MainBottonType.redBorderless)),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: dynamicCardColor,
      ),
    );

    return dynamicThemeData;
  }
}
