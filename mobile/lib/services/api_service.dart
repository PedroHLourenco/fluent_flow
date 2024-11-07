import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/language.dart';
import '../models/lesson.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:3000'; // URL do servidor JSON

  // **CRUD para Languages (Idiomas)**

  // Obter todos os idiomas
  Future<List<Language>> fetchLanguages() async {
    final response = await http.get(Uri.parse('$baseUrl/languages'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Language.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar idiomas');
    }
  }

  // Criar um novo idioma
  Future<void> addLanguage(String name) async {
    final response = await http.post(
      Uri.parse('$baseUrl/languages'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'name': name}),
    );
    if (response.statusCode != 201) {
      throw Exception('Falha ao adicionar idioma');
    }
  }

  // Atualizar um idioma existente
  Future<void> updateLanguage(int id, String name) async {
    final response = await http.put(
      Uri.parse('$baseUrl/languages/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'name': name}),
    );
    if (response.statusCode != 200) {
      throw Exception('Falha ao atualizar idioma');
    }
  }

  // Deletar um idioma
  Future<void> deleteLanguage(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/languages/$id'),
    );
    if (response.statusCode != 200) {
      throw Exception('Falha ao deletar idioma');
    }
  }

  // **CRUD para Lessons (Lições)**

  // Obter todas as lições
  Future<List<Lesson>> fetchLessons() async {
    final response = await http.get(Uri.parse('$baseUrl/lessons'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Lesson.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar lições');
    }
  }

  // Criar uma nova lição
  Future<void> addLesson(String title, int languageId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/lessons'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'title': title, 'languageId': languageId}),
    );
    if (response.statusCode != 201) {
      throw Exception('Falha ao adicionar lição');
    }
  }

  // Atualizar uma lição existente
  Future<void> updateLesson(int id, String title, int languageId) async {
    final response = await http.put(
      Uri.parse('$baseUrl/lessons/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'title': title, 'languageId': languageId}),
    );
    if (response.statusCode != 200) {
      throw Exception('Falha ao atualizar lição');
    }
  }

  // Deletar uma lição
  Future<void> deleteLesson(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/lessons/$id'),
    );
    if (response.statusCode != 200) {
      throw Exception('Falha ao deletar lição');
    }
  }
}
