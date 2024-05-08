import 'package:smart_assistant_app/presentation/common/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

final englishTextStyle = GoogleFonts.poppins();
final arabicTextStyle = GoogleFonts.almarai();
final robotoTextStyle = GoogleFonts.roboto();

final englishFontFamily = englishTextStyle.fontFamily;
final arabicFontFamily = arabicTextStyle.fontFamily!;

extension CustomTextStyles on TextStyle {
  /// Font Family

  TextStyle get toEnglishFont => englishTextStyle.copyWith(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: 0.0,
      fontFamily: englishFontFamily); // English
  TextStyle get toArabicFont =>
      arabicTextStyle.copyWith(fontSize: fontSize, fontWeight: fontWeight, color: color); // Arabic
  TextStyle get toRobotoFont => robotoTextStyle.copyWith(
      fontSize: fontSize, fontWeight: fontWeight, color: color, decoration: decoration); // Roboto

  /// Color
  TextStyle get toPrimaryWhiteColor => copyWith(color: AppColors.whiteColor);
  TextStyle get toRamliColor => copyWith(color: AppColors.ramliColor);
  TextStyle get toPrimaryGreyColor => copyWith(color: AppColors.primaryGreyA7Color);
  TextStyle get toPrimaryRedColor => copyWith(color: AppColors.primaryRed8AColor);
}

class TextStylesManager {
  static get almaraiFamily => arabicTextStyle.fontFamily;
  static TextTheme getAppTextTheme({required bool isArabic, required bool isDarkMode}) {
    final dynamicModeColor = isDarkMode ? AppColors.whiteColor : AppColors.primaryBlackishColor;

    final textStyle = isArabic
        ? arabicTextStyle.copyWith(color: dynamicModeColor).toArabicFont
        : englishTextStyle.copyWith(color: dynamicModeColor).toEnglishFont;

    final TextTheme defaultTextTheme = const TextTheme().copyWith(
      labelSmall: textStyle.copyWith(
        fontSize: 10.sp,
        fontWeight: FontWeight.w400,
        // fontFamilyFallback: [almaraiFamily, englishFontFamily],
      ),
    );
    return defaultTextTheme;
  }
}

class AppTextStyles {
  // px 10
  static TextStyle px10wRegular(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .labelSmall!
        .copyWith(fontSize: 10.sp, fontWeight: FontWeight.w400);
  }

  static TextStyle px10wMedium(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .labelSmall!
        .copyWith(fontSize: 10.sp, fontWeight: FontWeight.w500);
  }

  static TextStyle px10wSemiBold(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .labelSmall!
        .copyWith(fontSize: 10.sp, fontWeight: FontWeight.w600);
  }

  static TextStyle px10wBold(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .labelSmall!
        .copyWith(fontSize: 10.sp, fontWeight: FontWeight.w700);
  }

  // px 12
  static TextStyle px12wRegular(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .labelSmall!
        .copyWith(fontSize: 12.sp, fontWeight: FontWeight.w400);
  }

  static TextStyle px12wMedium(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .labelSmall!
        .copyWith(fontSize: 12.sp, fontWeight: FontWeight.w500);
  }

  static TextStyle px12wSemiBold(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .labelSmall!
        .copyWith(fontSize: 12.sp, fontWeight: FontWeight.w600);
  }

  static TextStyle px12wBold(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .labelSmall!
        .copyWith(fontSize: 12.sp, fontWeight: FontWeight.w700);
  }

  static TextStyle px13wRegular(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .labelSmall!
        .copyWith(fontSize: 13.sp, fontWeight: FontWeight.w400);
  }

  static TextStyle px13wSemiBold(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .labelSmall!
        .copyWith(fontSize: 13.sp, fontWeight: FontWeight.w600);
  }

  static TextStyle px13wBold(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .labelSmall!
        .copyWith(fontSize: 13.sp, fontWeight: FontWeight.w700);
  }

  // px 14
  static TextStyle px14wRegular(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .labelSmall!
        .copyWith(fontSize: 14.sp, fontWeight: FontWeight.w400);
  }

  static TextStyle px14wMedium(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .labelSmall!
        .copyWith(fontSize: 14.sp, fontWeight: FontWeight.w500);
  }

  static TextStyle px14wSemiBold(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .labelSmall!
        .copyWith(fontSize: 14.sp, fontWeight: FontWeight.w600);
  }

  static TextStyle px14wBold(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .labelSmall!
        .copyWith(fontSize: 14.sp, fontWeight: FontWeight.w800);
  }

  static TextStyle px15wLight(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .labelSmall!
        .copyWith(fontSize: 15.sp, fontWeight: FontWeight.w300);
  }

  static TextStyle px15wRegular(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .labelSmall!
        .copyWith(fontSize: 15.sp, fontWeight: FontWeight.w400);
  }

  static TextStyle px15wMedium(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .labelSmall!
        .copyWith(fontSize: 15.sp, fontWeight: FontWeight.w500);
  }

  // px 16
  static TextStyle px16wRegular(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .labelSmall!
        .copyWith(fontSize: 16.sp, fontWeight: FontWeight.w400);
  }

  static TextStyle px16wMedium(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .labelSmall!
        .copyWith(fontSize: 16.sp, fontWeight: FontWeight.w500);
  }

  static TextStyle px16wSemiBold(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .labelSmall!
        .copyWith(fontSize: 16.sp, fontWeight: FontWeight.w600);
  }

  static TextStyle px16wBold(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .labelSmall!
        .copyWith(fontSize: 16.sp, fontWeight: FontWeight.w700);
  }

  static TextStyle px18wRegular(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .labelSmall!
        .copyWith(fontSize: 18.sp, fontWeight: FontWeight.w400);
  }

  static TextStyle px18wSemiBold(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .labelSmall!
        .copyWith(fontSize: 18.sp, fontWeight: FontWeight.w600);
  }

  static TextStyle px18wBold(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .labelSmall!
        .copyWith(fontSize: 18.sp, fontWeight: FontWeight.w700);
  }

  // px 19
  static TextStyle px19wRegular(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .labelSmall!
        .copyWith(fontSize: 19.sp, fontWeight: FontWeight.w400);
  }

  static TextStyle px19wMedium(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .labelSmall!
        .copyWith(fontSize: 19.sp, fontWeight: FontWeight.w500);
  }

  static TextStyle px19wSemiBold(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .labelSmall!
        .copyWith(fontSize: 19.sp, fontWeight: FontWeight.w600);
  }

  static TextStyle px19wBold(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .labelSmall!
        .copyWith(fontSize: 19.sp, fontWeight: FontWeight.w700);
  }

  static TextStyle px20wSemiBold(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .labelSmall!
        .copyWith(fontSize: 20.sp, fontWeight: FontWeight.w600);
  }

  static TextStyle px20wBold(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .labelSmall!
        .copyWith(fontSize: 20.sp, fontWeight: FontWeight.w700);
  }

  static TextStyle px24wSemiBold(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .labelSmall!
        .copyWith(fontSize: 24.sp, fontWeight: FontWeight.w600);
  }

  static TextStyle px25wSemiBold(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .labelSmall!
        .copyWith(fontSize: 25.sp, fontWeight: FontWeight.w600);
  }

  // px 28
  static TextStyle px28wRegular(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .labelSmall!
        .copyWith(fontSize: 28.sp, fontWeight: FontWeight.w400);
  }

  static TextStyle px28wMedium(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .labelSmall!
        .copyWith(fontSize: 28.sp, fontWeight: FontWeight.w500);
  }

  static TextStyle px28wSemiBold(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .labelSmall!
        .copyWith(fontSize: 28.sp, fontWeight: FontWeight.w600);
  }

  static TextStyle px28wBold(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .labelSmall!
        .copyWith(fontSize: 28.sp, fontWeight: FontWeight.w700);
  }

  static TextStyle px32wBold(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .labelSmall!
        .copyWith(fontSize: 32.sp, fontWeight: FontWeight.w700);
  }
}
