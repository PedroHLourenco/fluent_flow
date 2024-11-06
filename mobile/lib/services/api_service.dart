import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/language.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:3000/languages';

  Future<List<Language>> getLinguas() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Language.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar Línguas');
    }
  }

  Future<void> postLinguas(Language lingua) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(lingua.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Falha ao adicionar língua');
    }
  }

  Future<void> putLingua(Language lingua) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${lingua.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(lingua.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Falha ao atualizar língua');
    }
  }

  Future<void> deleteLingua(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/$id'),
    );

    if (response.statusCode != 200) {
      throw Exception('Falha ao deletar língua');
    }
  }
}
