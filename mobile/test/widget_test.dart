import 'dart:convert';
import 'package:mobile/services/api_service.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/models/language.dart';
import 'package:mobile/models/lesson.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late ApiService apiService;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    apiService = ApiService(client: mockHttpClient);
  });

  group('ApiService Tests', () {
    test('should return a list of languages when the response is successful',
        () async {
      when(() =>
              mockHttpClient.get(Uri.parse('http://localhost:3000/languages')))
          .thenAnswer((_) async => http.Response(
                jsonEncode([
                  {'id': 1, 'name': 'Inglês'},
                  {'id': 2, 'name': 'Espanhol'},
                ]),
                200,
              ));

      final result = await apiService.getLanguages();

      expect(result, isA<List<Language>>());
      expect(result.length, 2);
      expect(result[0].name, 'Inglês');
    });

    test('should throw an exception when the response is an error', () async {
      when(() =>
              mockHttpClient.get(Uri.parse('http://localhost:3000/languages')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(() => apiService.getLanguages(), throwsException);
    });

    test('should add a language when the response is successful', () async {
      when(() => mockHttpClient.post(
                Uri.parse('http://localhost:3000/languages'),
                headers: any(named: 'headers'),
                body: any(named: 'body'),
              ))
          .thenAnswer(
              (_) async => http.Response('{"id": 3, "name": "Francês"}', 201));

      await apiService.addLanguage('Francês' as Language);

      verify(() => mockHttpClient.post(
            Uri.parse('http://localhost:3000/languages'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'name': 'Francês'}),
          )).called(1);
    });

    test('should throw an exception when adding a language fails', () async {
      when(() => mockHttpClient.post(
                Uri.parse('http://localhost:3000/languages'),
                headers: any(named: 'headers'),
                body: any(named: 'body'),
              ))
          .thenAnswer(
              (_) async => http.Response('Failed to add language', 500));

      expect(() => apiService.addLanguage('Francês' as Language), throwsException);
    });

    test('should return a list of lessons when the response is successful',
        () async {
      when(() => mockHttpClient.get(Uri.parse('http://localhost:3000/lessons')))
          .thenAnswer((_) async => http.Response(
                jsonEncode([
                  {'id': 1, 'title': 'Saudações em Inglês', 'languageId': 1},
                  {
                    'id': 2,
                    'title': 'Frases Comuns em Espanhol',
                    'languageId': 2
                  },
                ]),
                200,
              ));

      final result = await apiService.getLessons();

      expect(result, isA<List<Lesson>>());
      expect(result.length, 2);
      expect(result[0].title, 'Saudações em Inglês');
    });

    test('should throw an exception when fetching lessons fails', () async {
      when(() => mockHttpClient.get(Uri.parse('http://localhost:3000/lessons')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(() => apiService.getLessons(), throwsException);
    });
  });
}
