import 'package:flutter/material.dart';

class LanguageServices {
  Locale getLocale(String locale) {
    debugPrint(locale);
    return locale == "en_US"
        ? const Locale('pt', 'BR')
        : const Locale('en', 'US');
  }
}
