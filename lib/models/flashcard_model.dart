class Flashcard {
  Flashcard({
    this.id,
    this.front,
    this.back,
    this.createdAt,
  });

  final int id;
  final String front;
  final String back;
  final DateTime createdAt;

  factory Flashcard.fromStringList(List<String> strList) {
    return Flashcard(
      id: int.parse(strList[0]),
      front: strList[1],
      back: strList[2],
      createdAt: DateTime.parse(strList[3]),
    );
  }

  List<String> toStringList() {
    return [
      id.toString(),
      front,
      back,
      createdAt.toIso8601String(),
    ];
  }

  @override
  String toString() {
    return 'Flashcard{id: $id, front: $front, back: $back, createdAt: $createdAt}';
  }
}
