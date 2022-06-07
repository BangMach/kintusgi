import 'package:flutter/cupertino.dart';
import 'package:kintsugi/services/locale_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ThemeMode {
  light,
  dark,
}

enum AccessibilityMode {
  NONE,
  VISUAL,
  HEARING,
  ADHD,
  DYSLEXIA,
}

abstract class UserReferencesBase {
  void initialize(BuildContext context);

  ThemeMode get themeMode;
  List<AccessibilityMode> get accessibilityModes;

  void setThemeMode(ThemeMode themeMode);
  void setAccessibilityMode(AccessibilityMode mode);
}

List<AccessibilityMode> stringToAccessibilityModes(List<String> modes) {
  if (modes == null) {
    return [];
  }

  return modes.map((mode) {
    switch (mode) {
      case 'AccessibilityMode.VISUAL':
        return AccessibilityMode.VISUAL;
      case 'AccessibilityMode.HEARING':
        return AccessibilityMode.HEARING;
      case 'AccessibilityMode.ADHD':
        return AccessibilityMode.ADHD;
      case 'AccessibilityMode.DYSLEXIA':
        return AccessibilityMode.DYSLEXIA;
    }
  }).toList();
}

class UserReferences implements UserReferencesBase {
  bool _initialized = false;
  SharedPreferences _prefs;

  ThemeMode _themeMode = ThemeMode.light;
  List<AccessibilityMode> _accessibilityModes = [];

  void initialize(BuildContext context) async {
    if (_initialized) return;

    final _localeProvider = Provider.of<LocaleProvider>(context);
    _prefs = await SharedPreferences.getInstance();

    _themeMode =
        _prefs.getInt('themeMode') == 1 ? ThemeMode.dark : ThemeMode.light;
    _accessibilityModes = stringToAccessibilityModes(
            _prefs.getStringList('accessibilityModes')) ??
        [];
    _localeProvider.setLocale(Locale(_prefs.getString('locale') ?? 'en'));

    _initialized = true;
  }

  @override
  ThemeMode get themeMode => _themeMode;

  @override
  List<AccessibilityMode> get accessibilityModes => _accessibilityModes;

  @override
  void setThemeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
    _prefs.setString('themeMode', themeMode.toString());
  }

  @override
  void setAccessibilityMode(AccessibilityMode mode) {
    if (mode != AccessibilityMode.DYSLEXIA) {
      // If it does not yet exist, add it to the list
      if (!_accessibilityModes.contains(mode)) {
        _accessibilityModes.add(mode);
      } else {
        // If it already exists, remove it from the list
        _accessibilityModes.remove(mode);
      }

      _prefs.setStringList(
        'accessibilityModes',
        _accessibilityModes.map((e) => e.toString()).toList(),
      );
    }
  }
}
