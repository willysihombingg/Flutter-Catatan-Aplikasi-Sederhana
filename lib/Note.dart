class Note {
  final String title;
  final String body;

  Note({required this.title, required this.body});

  Map<String, dynamic> toMap() {
    return {'title': title, 'body': body};
  }

  @override
  String toString() {
    return 'Note(title: $title, body: $body)';
  }
}
