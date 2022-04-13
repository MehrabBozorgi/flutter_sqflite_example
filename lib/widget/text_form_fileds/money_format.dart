import 'package:flutter/services.dart';

class ThousandsSeparator extends TextInputFormatter {
  static const separator = ',';

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) return newValue.copyWith(text: '');

    String oldValueText = oldValue.text.replaceAll(separator, '');
    String newValueText = newValue.text.replaceAll(separator, '');

    if (oldValue.text.endsWith(separator) &&
        oldValue.text.length == newValue.text.length + 1) {
      newValueText = newValueText.substring(0, newValueText.length - 1);
    }

    if (oldValueText != newValueText) {
      int selectionIndex =
          newValue.text.length - newValue.selection.extentOffset;

      final chars = newValueText.split('');
      String newString = '';

      for (int i = chars.length - 1; i >= 0; i--) {
        if ((chars.length - 1 - i) % 3 == 0 && i != chars.length - 1) {
          newString = separator + newString;
        }

        newString = chars[i] + newString;
      }

      return TextEditingValue(
        text: newString.toString(),
        selection:
            TextSelection.collapsed(offset: newString.length - selectionIndex),
      );
    }

    return newValue;
  }
}
