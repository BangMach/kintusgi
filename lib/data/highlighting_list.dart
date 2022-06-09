class HighlightingList {
  // Words to be highlighted
  static const List<String> words = [
    'happy',
    'sad',
    'angry',
    'sick',
    'tired',
    'hungry',
    'thirsty',
    'sleepy',
    'lonely',
  ];

  // Don't edit below this line
  static bool checkIfHighlightable(String word) => words.any((w) => w == word);
}
