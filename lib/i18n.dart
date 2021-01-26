import 'package:flutter/material.dart';
import 'package:flutter_translate/global.dart';
import 'package:flutter_translate/translate_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TranslatePreferences implements ITranslatePreferences {
  static const String _selectedLocaleKey = "selected_locale";

  @override
  Future<Locale> getPreferredLocale() async {
    final pref = await SharedPreferences.getInstance();
    if (!pref.containsKey(_selectedLocaleKey)) return null;

    return localeFromString(pref.getString(_selectedLocaleKey));
  }

  @override
  Future savePreferredLocale(Locale locale) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString(_selectedLocaleKey, localeToString(locale));
  }
}
