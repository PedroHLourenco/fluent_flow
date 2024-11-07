import 'dart:convert';
import 'package:mobile/services/api_service.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/models/language.dart';
import 'package:mobile/models/lesson.dart';

// Criando um Mock da classe http.Client usando mocktail
class MockHttpClient extends Mock implements http.Client {}

void main() {
  late ApiService apiService;
  late MockHttpClient mockHttpClient;

  // Inicializa o ApiService e o mockHttpClient antes de cada teste
  setUp(() {
    mockHttpClient = MockHttpClient();
    apiService = ApiService();
  });

  group('ApiService Tests', () {
    // Teste de GET para obter idiomas
    test('should return a list of languages when the response is successful', () async {
      // Definindo o comportamento do mockHttpClient
      when(() => mockHttpClient.get(Uri.parse('http://localhost:3000/languages')))
          .thenAnswer((_) async => http.Response(
                jsonEncode([
                  {'id': 1, 'name': 'Inglês'},
                  {'id': 2, 'name': 'Espanhol'},
                ]),
                200,
              ));

      // Chama o método que está sendo testado
      final result = await apiService.fetchLanguages();

      // Verificando o resultado
      expect(result, isA<List<Language>>());
      expect(result.length, 2);
      expect(result[0].name, 'Inglês');
    });

    test('should throw an exception when the response is an error', () async {
      // Simulando um erro na requisição
      when(() => mockHttpClient.get(Uri.parse('http://localhost:3000/languages')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      // Verificando se a exceção é lançada
      expect(() => apiService.fetchLanguages(), throwsException);
    });

    // Teste de POST para adicionar um idioma
    test('should add a language when the response is successful', () async {
      // Definindo o comportamento do mockHttpClient
      when(() => mockHttpClient.post(
            Uri.parse('http://localhost:3000/languages'),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          )).thenAnswer((_) async => http.Response('{"id": 3, "name": "Francês"}', 201));

      // Chamando o método para adicionar o idioma
      await apiService.addLanguage('Francês');

      // Verificando se a chamada foi feita corretamente
      verify(() => mockHttpClient.post(
            Uri.parse('http://localhost:3000/languages'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'name': 'Francês'}),
          )).called(1);
    });

    test('should throw an exception when adding a language fails', () async {
      // Simulando uma falha ao adicionar o idioma
      when(() => mockHttpClient.post(
            Uri.parse('http://localhost:3000/languages'),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          )).thenAnswer((_) async => http.Response('Failed to add language', 500));

      // Verificando se a exceção é lançada
      expect(() => apiService.addLanguage('Francês'), throwsException);
    });

    // Teste de PUT para atualizar um idioma
    test('should update a language when the response is successful', () async {
      // Simulando uma resposta bem-sucedida
      when(() => mockHttpClient.put(
            Uri.parse('http://localhost:3000/languages/1'),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          )).thenAnswer((_) async => http.Response('{"id": 1, "name": "Alemão"}', 200));

      // Chamando o método para atualizar o idioma
      await apiService.updateLanguage(1, 'Alemão');

      // Verificando se o método PUT foi chamado corretamente
      verify(() => mockHttpClient.put(
            Uri.parse('http://localhost:3000/languages/1'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'name': 'Alemão'}),
          )).called(1);
    });

    test('should throw an exception when updating a language fails', () async {
      // Simulando falha ao atualizar o idioma
      when(() => mockHttpClient.put(
            Uri.parse('http://localhost:3000/languages/1'),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          )).thenAnswer((_) async => http.Response('Failed to update language', 500));

      // Verificando se a exceção é lançada
      expect(() => apiService.updateLanguage(1, 'Alemão'), throwsException);
    });

    // Teste de DELETE para deletar um idioma
    test('should delete a language when the response is successful', () async {
      // Simulando resposta de sucesso para DELETE
      when(() => mockHttpClient.delete(Uri.parse('http://localhost:3000/languages/1')))
          .thenAnswer((_) async => http.Response('{"id": 1, "name": "Inglês"}', 200));

      // Chamando o método para deletar
      await apiService.deleteLanguage(1);

      // Verificando se o método DELETE foi chamado corretamente
      verify(() => mockHttpClient.delete(Uri.parse('http://localhost:3000/languages/1')))
          .called(1);
    });

    test('should throw an exception when deleting a language fails', () async {
      // Simulando falha ao deletar o idioma
      when(() => mockHttpClient.delete(Uri.parse('http://localhost:3000/languages/1')))
          .thenAnswer((_) async => http.Response('Failed to delete language', 500));

      // Verificando se a exceção é lançada
      expect(() => apiService.deleteLanguage(1), throwsException);
    });

    // Testes para Lições (Lessons)

    test('should return a list of lessons when the response is successful', () async {
      when(() => mockHttpClient.get(Uri.parse('http://localhost:3000/lessons')))
          .thenAnswer((_) async => http.Response(
                jsonEncode([
                  {'id': 1, 'title': 'Saudações em Inglês', 'languageId': 1},
                  {'id': 2, 'title': 'Frases Comuns em Espanhol', 'languageId': 2},
                ]),
                200,
              ));

      final result = await apiService.fetchLessons();

      expect(result, isA<List<Lesson>>());
      expect(result.length, 2);
      expect(result[0].title, 'Saudações em Inglês');
    });

    test('should throw an exception when fetching lessons fails', () async {
      when(() => mockHttpClient.get(Uri.parse('http://localhost:3000/lessons')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(() => apiService.fetchLessons(), throwsException);
    });

    // Testes de POST, PUT, DELETE para Lições podem ser feitos de forma semelhante
  });
}
