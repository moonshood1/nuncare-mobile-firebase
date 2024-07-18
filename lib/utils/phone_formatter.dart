import 'package:flutter/services.dart';

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text.replaceAll(' ', '');

    String formattedText = '';

    if (newText.length > 10) {
      newText = newText.substring(0, 10);
    }

    for (int i = 0; i < newText.length; i += 2) {
      if (i + 2 <= newText.length) {
        formattedText += newText.substring(i, i + 2) + ' ';
      } else {
        formattedText += newText.substring(i);
      }
    }

    if (formattedText.endsWith(' ')) {
      formattedText = formattedText.substring(0, formattedText.length - 1);
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
