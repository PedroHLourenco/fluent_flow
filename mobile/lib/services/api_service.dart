import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile/models/language.dart';
import 'package:mobile/models/lesson.dart';

class ApiService {
  final client = http.Client();
  final String baseUrl = 'http://localhost:3000';

  Future<List<Language>> getLanguages() async {
    final response = await client.get(Uri.parse('$baseUrl/languages'));
    if (response.statusCode == 200) {
      final List languagesJson = jsonDecode(response.body);
      return languagesJson.map((json) => Language.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar idiomas');
    }
  }

  Future<Language> getLanguageById(int id) async {
    final response = await client.get(Uri.parse('$baseUrl/languages/$id'));
    if (response.statusCode == 200) {
      return Language.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Falha ao carregar idioma');
    }
  }

  Future<Language> addLanguage(String name) async {
    final response = await client.post(
      Uri.parse('$baseUrl/languages'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name}),
    );

    if (response.statusCode == 201) {
      return Language.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Falha ao adicionar idioma');
    }
  }

  Future<Language> updateLanguage(int id, String name) async {
    final response = await client.put(
      Uri.parse('$baseUrl/languages/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name}),
    );

    if (response.statusCode == 200) {
      return Language.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Falha ao atualizar idioma');
    }
  }

  Future<void> deleteLanguage(int id) async {
    final response = await client.delete(Uri.parse('$baseUrl/languages/$id'));
    if (response.statusCode != 200) {
      throw Exception('Falha ao excluir idioma');
    }
  }

  Future<List<Lesson>> getLessons() async {
    final response = await client.get(Uri.parse('$baseUrl/lessons'));
    if (response.statusCode == 200) {
      final List lessonsJson = jsonDecode(response.body);
      return lessonsJson.map((json) => Lesson.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar lições');
    }
  }

  Future<Lesson> addLesson(String title, int languageId) async {
    final response = await client.post(
      Uri.parse('$baseUrl/lessons'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'title': title, 'languageId': languageId}),
    );

    if (response.statusCode == 201) {
      return Lesson.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Falha ao adicionar lição');
    }
  }

  Future<Lesson> updateLesson(int id, String title, int languageId) async {
    final response = await client.put(
      Uri.parse('$baseUrl/lessons/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'title': title, 'languageId': languageId}),
    );

    if (response.statusCode == 200) {
      return Lesson.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Falha ao atualizar lição');
    }
  }

  Future<void> deleteLesson(int id) async {
    final response = await client.delete(Uri.parse('$baseUrl/lessons/$id'));
    if (response.statusCode != 200) {
      throw Exception('Falha ao excluir lição');
    }
  }
}
