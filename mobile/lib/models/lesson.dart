class Lesson {
  final int id;
  final String title;
  final int languageId;

  Lesson({required this.id, required this.title, required this.languageId});

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: int.parse(json['id'].toString()),
      title: json['title'],
      languageId: json['languageId'],
    );
  }
}
