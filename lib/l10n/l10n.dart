import 'package:flutter/material.dart';

class L10n {
  static final all = [
    const Locale('en'),
    const Locale('vi'),
  ];

  static String getFlag(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return '🇺🇸';
      case 'vi':
        return '🇻🇳';
      default:
        return '🇺🇸';
    }
  }
}
