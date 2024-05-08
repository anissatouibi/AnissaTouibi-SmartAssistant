import 'package:smart_assistant_app/presentation/common/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class SmartText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final int? maxLines;

  const SmartText(
    this.text, {
    super.key,
    required this.style,
    this.maxLines,
  });

  bool isArabicText(String text) {
    final arabicRegex =
        RegExp(r'[\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF\uFB50-\uFBC1\uFE70-\uFEFC]');
    return arabicRegex.hasMatch(text);
  }

  @override
  Widget build(BuildContext context) {
    final words = text.split(' ');

    final spans = <InlineSpan>[];

    for (var i = 0; i < words.length; i++) {
      final word = words[i];
      final isArabic = isArabicText(word);
      final dynamicStyle = isArabic ? style.toArabicFont : style.toEnglishFont;

      spans.add(TextSpan(
        text: word,
        style: dynamicStyle,
      ));

      if (i < words.length - 1) {
        spans.add(const TextSpan(text: ' ')); // Add space between words
      }
    }

    return RichText(
      text: TextSpan(children: spans),
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }
}
