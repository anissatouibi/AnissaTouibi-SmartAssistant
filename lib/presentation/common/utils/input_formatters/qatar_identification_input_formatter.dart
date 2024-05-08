import 'package:flutter/services.dart';

class QatarIDInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final unformattedText = newValue.text.replaceAll(' ', '');
    final formattedText = _formatString(unformattedText);
    final selectionIndex = formattedText.length;

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }

  String _formatString(String value) {
    final trimmedValue = value.substring(0, value.length.clamp(0, 11));
    final parts = <String>[];
    for (var i = 0; i < trimmedValue.length; i++) {
      if (i == 1 || i == 3 || i == 6) {
        parts.add(' ');
      }
      parts.add(trimmedValue[i]);
    }
    return parts.join('');
  }
}
