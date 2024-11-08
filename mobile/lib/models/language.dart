class Language {
  late final int id;
  final String name;

  Language({required this.id, required this.name});

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      id: int.parse(json['id'].toString()),
      name: json['name'],
    );
  }
}
