class Note {
  Note({
    this.id,
    this.title,
    this.content,
    this.createdAt,
  });

  final int id;
  final String title;
  final String content;
  final DateTime createdAt;

  factory Note.fromStringList(List<String> strList) {
    return Note(
      id: int.parse(strList[0]),
      title: strList[1],
      content: strList[2],
      createdAt: DateTime.parse(strList[3]),
    );
  }

  List<String> toStringList() {
    return [
      id.toString(),
      title,
      content,
      createdAt.toIso8601String(),
    ];
  }

  @override
  String toString() {
    return 'Note {id: $id, title: $title, content: $content, createdAt: $createdAt}';
  }
}
