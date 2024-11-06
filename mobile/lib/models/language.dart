class Language {
  final int id;
  final String nome;
  final String descricao;

  Language({required this.id, required this.nome, required this.descricao});

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      id: json['id'],
      nome: json['nome'],
      descricao: json['descrição'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'descrição': descricao,
    };
  }
}
