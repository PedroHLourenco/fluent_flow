import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/language.dart';
import '../models/lesson.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:3000';

  Future<List<Language>> getLanguages() async {
    final response = await http.get(Uri.parse('$baseUrl/languages'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => Language.fromJson(item)).toList();
    } else {
      throw Exception('Falha ao carregar idiomas');
    }
  }

  Future<List<Lesson>> getLessons() async {
    final response = await http.get(Uri.parse('$baseUrl/lessons'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => Lesson.fromJson(item)).toList();
    } else {
      throw Exception('Falha ao carregar lições');
    }
  }

  Future<void> addLanguage(Language language) async {
    final response = await http.post(
      Uri.parse('$baseUrl/languages'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'name': language.name}),
    );

    if (response.statusCode == 201) {
      final data = json.decode(response.body);
      language.id = data['id'];
    } else {
      throw Exception('Falha ao adicionar idioma');
    }
  }

  Future<void> addLesson(Lesson lesson) async {
    final response = await http.post(
      Uri.parse('$baseUrl/lessons'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'title': lesson.title, 'languageId': lesson.languageId}),
    );

    if (response.statusCode == 201) {
      final data = json.decode(response.body);
      lesson.id = data['id'];
    } else {
      throw Exception('Falha ao adicionar lição');
    }
  }

  Future<void> updateLanguage(Language language) async {
    final response = await http.put(
      Uri.parse('$baseUrl/languages/${language.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'name': language.name}),
    );

    if (response.statusCode != 200) {
      throw Exception('Falha ao atualizar idioma');
    }
  }

  Future<void> updateLesson(Lesson lesson) async {
    final response = await http.put(
      Uri.parse('$baseUrl/lessons/${lesson.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'title': lesson.title, 'languageId': lesson.languageId}),
    );

    if (response.statusCode != 200) {
      throw Exception('Falha ao atualizar lição');
    }
  }

  Future<void> deleteLanguage(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/languages/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Falha ao deletar idioma');
    }
  }

  Future<void> deleteLesson(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/lessons/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Falha ao deletar lição');
    }
  }
}
