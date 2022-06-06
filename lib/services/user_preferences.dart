import 'package:kintsugi/services/auth.dart';

enum Locales {
  en,
  vi,
}

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
  Locales get locale;
  ThemeMode get themeMode;
  AccessibilityMode get accessibilityMode;
}

// class UserReferences implements UserReferencesBase {}
