import 'package:flutter/material.dart';
import 'package:kintsugi/models/flashcard_model.dart';
import 'package:kintsugi/models/note_model.dart';
import 'package:kintsugi/services/locale_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ThemeMode {
  light,
  dark,
}

enum AccessibilityMode {
  VISUAL,
  HEARING,
  ADHD,
  DYSLEXIA,
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

abstract class ResourceManagerBase {
  void initialize(BuildContext context);
  void loadResources(BuildContext context);

  bool get initialized;

  Locale get locale;
  ThemeMode get theme;
  List<AccessibilityMode> get accessibilityModes;
  List<Flashcard> get flashcards;
  List<Note> get notes;

  void loadLocale(BuildContext context);
  void saveLocale();
  void updateLocale(Locale locale);

  void loadTheme();
  void saveTheme();
  void updateTheme(ThemeMode theme);

  void loadAccessibilityModes();
  void saveAccessibilityModes();
  void updateAccessibilityModes(List<AccessibilityMode> modes);
  void toggleAccessibilityMode(AccessibilityMode mode);

  void loadFlashcards();
  Future<void> saveFlashcards();
  void updateFlashcards(List<Flashcard> flashcards);
  int getNextFlashcardId();
  Future<void> updateFlashcard(Flashcard flashcard);
  Future<void> removeFlashcard(Flashcard flashcard);

  void loadNotes();
  Future<void> saveNotes();
  void updateNotes(List<Note> notes);
  int getNextNoteId();
  Future<void> updateNote(Note note);
  Future<void> removeNote(Note note);
}

class ResourceManager implements ResourceManagerBase {
  bool _initialized = false;
  SharedPreferences _prefs;

  Locale _locale = Locale('en');
  ThemeMode _theme = ThemeMode.light;
  List<AccessibilityMode> _accessibilityModes = [];
  List<Flashcard> _flashcards = [];
  List<Note> _notes = [];

  void initialize(BuildContext context) async {
    if (_initialized) return;

    _prefs = await SharedPreferences.getInstance();
    _initialized = true;

    loadResources(context);
  }

  void loadResources(BuildContext context) {
    loadLocale(context);
    loadTheme();
    loadAccessibilityModes();
    loadFlashcards();
    loadNotes();
  }

  bool get initialized => _initialized;

  Locale get locale => _locale ?? Locale('en');
  ThemeMode get theme => _theme ?? ThemeMode.light;
  List<AccessibilityMode> get accessibilityModes => _accessibilityModes ?? [];
  List<Flashcard> get flashcards => _flashcards ?? [];
  List<Note> get notes => _notes ?? [];

  void loadLocale(BuildContext context) {
    _locale = Locale(_prefs.getString('locale') ?? 'en');

    final _localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    _localeProvider.setLocale(context, _locale);

    print('Loaded locale: ${_locale.languageCode}');
  }

  void saveLocale() async {
    if (!_initialized) return;
    bool success = await _prefs.setString('locale', _locale.languageCode);

    if (success) {
      print('Saved locale: ${_locale.languageCode}');
    } else {
      print('Failed to save locale: ${_locale.languageCode}');
    }
  }

  void updateLocale(Locale locale) {
    if (!_initialized) return;
    _locale = locale;
    saveLocale();
  }

  void loadTheme() {
    _theme = _prefs.getInt('themeMode') == 1 ? ThemeMode.dark : ThemeMode.light;
    print('Loaded theme: $_theme');
  }

  void saveTheme() async {
    if (!_initialized) return;
    bool success =
        await _prefs.setInt('themeMode', _theme == ThemeMode.dark ? 1 : 0);

    if (success) {
      print('Saved theme: $_theme');
    } else {
      print('Failed to save theme: $_theme');
    }
  }

  void updateTheme(ThemeMode theme) {
    if (!_initialized) return;
    _theme = theme;
    saveTheme();
  }

  void loadAccessibilityModes() {
    _accessibilityModes = stringToAccessibilityModes(
            _prefs.getStringList('accessibilityModes')) ??
        [];
    print('Loaded accessibility modes: $_accessibilityModes');
  }

  void saveAccessibilityModes() async {
    if (!_initialized) return;
    bool success = await _prefs.setStringList(
      'accessibilityModes',
      _accessibilityModes.map((mode) => mode.toString()).toList(),
    );

    if (success) {
      print('Saved accessibility modes: $_accessibilityModes');
    } else {
      print('Failed to save accessibility modes: $_accessibilityModes');
    }
  }

  void updateAccessibilityModes(List<AccessibilityMode> modes) {
    if (!_initialized) return;
    _accessibilityModes = modes;
    saveAccessibilityModes();
  }

  void toggleAccessibilityMode(AccessibilityMode mode) {
    if (!_initialized) return;

    // Dyslexia mode is not currently supported.
    if (mode == AccessibilityMode.DYSLEXIA) return;

    if (_accessibilityModes.contains(mode))
      // If the mode is already enabled, remove it.
      _accessibilityModes.remove(mode);
    else
      // If the mode is not enabled, add it.
      _accessibilityModes.add(mode);

    saveAccessibilityModes();
  }

  void loadFlashcards() {
    _flashcards = _prefs.getStringList('availableFlashcardPaths')?.map((path) {
          return Flashcard.fromStringList(_prefs.getStringList(path));
        })?.toList() ??
        [];
    print('Loaded ${_flashcards.length} flashcards');

    _flashcards.forEach((flashcard) {
      print('Flashcard: ${flashcard.front}');
    });
  }

  Future<void> saveFlashcards() async {
    if (!_initialized) return;
    bool success = false;

    for (final flashcard in _flashcards) {
      final path = 'flashcard_${flashcard.id}';
      success = await _prefs.setStringList(path, flashcard.toStringList());

      if (success) {
        print('Saved flashcard: $path');
      } else {
        print('Failed to save flashcard: $path');
      }
    }

    final availableFlashcardPaths =
        _flashcards.map((flashcard) => 'flashcard_${flashcard.id}').toList();
    success = await _prefs.setStringList(
        'availableFlashcardPaths', availableFlashcardPaths);

    if (success) {
      print('Saved ${_flashcards.length} flashcards');
    } else {
      print('Failed to save ${_flashcards.length} flashcards');
    }
  }

  int getNextFlashcardId() {
    if (!_initialized) return 0;

    int highestId = 0;
    for (final flashcard in _flashcards)
      if (flashcard.id > highestId) highestId = flashcard.id;

    return highestId + 1;
  }

  void updateFlashcards(List<Flashcard> flashcards) {
    if (!_initialized) return;
    _flashcards = flashcards;
    saveFlashcards();
  }

  Future<void> updateFlashcard(Flashcard flashcard) async {
    if (!_initialized) return;

    if (!_flashcards.any((f) => f.id == flashcard.id)) {
      // If the flashcard's ID doesn't exist, add it.
      _flashcards.add(flashcard);
    } else {
      // If the flashcard's ID exists, update it.
      final index = _flashcards.indexWhere((f) => f.id == flashcard.id);
      _flashcards[index] = flashcard;
    }

    await saveFlashcards();
  }

  Future<void> removeFlashcard(Flashcard flashcard) async {
    if (!_initialized) return;
    _flashcards.remove(flashcard);
    await saveFlashcards();
  }

  void loadNotes() {
    _notes = _prefs.getStringList('availableNotePaths')?.map((path) {
          return Note.fromStringList(_prefs.getStringList(path));
        })?.toList() ??
        [];
    print('Loaded ${_notes.length} notes');

    _notes.forEach((note) {
      print('Note: ${note.title}');
    });
  }

  Future<void> saveNotes() async {
    if (!_initialized) return;
    bool success = false;

    for (final note in _notes) {
      final path = 'note_${note.id}';
      success = await _prefs.setStringList(path, note.toStringList());

      if (success) {
        print('Saved note: $path');
      } else {
        print('Failed to save note: $path');
      }
    }

    final availableNotePaths = _notes.map((note) => 'note_${note.id}').toList();
    success =
        await _prefs.setStringList('availableNotePaths', availableNotePaths);

    if (success) {
      print('Saved ${_notes.length} notes');
    } else {
      print('Failed to save ${_notes.length} notes');
    }
  }

  int getNextNoteId() {
    if (!_initialized) return 0;

    int highestId = 0;
    for (final note in _notes) if (note.id > highestId) highestId = note.id;

    return highestId + 1;
  }

  void updateNotes(List<Note> notes) {
    if (!_initialized) return;
    _notes = notes;
    saveNotes();
  }

  Future<void> updateNote(Note note) async {
    if (!_initialized) return;

    if (!_notes.any((n) => n.id == note.id)) {
      // If the note's ID doesn't exist, add it.
      _notes.add(note);
    } else {
      // If the note's ID exists, update it.
      final index = _notes.indexWhere((n) => n.id == note.id);
      _notes[index] = note;
    }
    print("Notes: $_notes");

    await saveNotes();
  }

  Future<void> removeNote(Note note) async {
    if (!_initialized) return;
    _notes.remove(note);
    await saveNotes();
  }
}
