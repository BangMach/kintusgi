import 'package:flutter/cupertino.dart';
import 'package:kintsugi/l10n/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale;

  Locale get locale => _locale;

  void setLocale(Locale locale) async {
    if (!L10n.all.contains(locale)) return;
    _locale = locale;

    final _prefs = await SharedPreferences.getInstance();
    _prefs.setString('locale', locale.languageCode);

    notifyListeners();
  }

  void clearLocale() async {
    _locale = null;

    final _prefs = await SharedPreferences.getInstance();
    _prefs.remove('locale');

    notifyListeners();
  }
}
