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
  ThemeMode get themeMode;
  List<AccessibilityMode> get accessibilityModes;

  void setThemeMode(ThemeMode themeMode);
  void setAccessibilityMode(AccessibilityMode mode);
}

class UserReferences implements UserReferencesBase {
  ThemeMode _themeMode = ThemeMode.light;
  List<AccessibilityMode> _accessibilityModes = [];

  @override
  ThemeMode get themeMode => _themeMode;

  @override
  List<AccessibilityMode> get accessibilityModes => _accessibilityModes;

  @override
  void setThemeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
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
    }
  }
}
