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

  Future<Language> getLanguageById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/languages/$id'));
    if (response.statusCode == 200) {
      return Language.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao carregar idioma');
    }
  }

  Future<void> addLanguage(Language language) async {
    final response = await http.post(
      Uri.parse('$baseUrl/languages'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'name': language.name}),
    );
    if (response.statusCode != 201) throw Exception('Falha ao adicionar idioma');
  }

  Future<void> updateLanguage(Language language) async {
    final response = await http.put(
      Uri.parse('$baseUrl/languages/${language.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'name': language.name}),
    );
    if (response.statusCode != 200) throw Exception('Falha ao atualizar idioma');
  }

  Future<void> deleteLanguage(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/languages/$id'));
    if (response.statusCode != 200) throw Exception('Falha ao deletar idioma');
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

  Future<Lesson> getLessonById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/lessons/$id'));
    if (response.statusCode == 200) {
      return Lesson.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao carregar lição');
    }
  }

  Future<void> addLesson(Lesson lesson) async {
    final response = await http.post(
      Uri.parse('$baseUrl/lessons'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'title': lesson.title, 'languageId': lesson.languageId}),
    );
    if (response.statusCode != 201) throw Exception('Falha ao adicionar lição');
  }

  Future<void> updateLesson(Lesson lesson) async {
    final response = await http.put(
      Uri.parse('$baseUrl/lessons/${lesson.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'title': lesson.title, 'languageId': lesson.languageId}),
    );
    if (response.statusCode != 200) throw Exception('Falha ao atualizar lição');
  }

  Future<void> deleteLesson(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/lessons/$id'));
    if (response.statusCode != 200) throw Exception('Falha ao deletar lição');
  }
}
