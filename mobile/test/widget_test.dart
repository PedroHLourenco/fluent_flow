import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mobile/screens/list_screen.dart';
import 'package:mobile/models/language.dart';
import 'package:mobile/services/api_service.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  // Testes Unitários
  group('Testes Unitários', () {
    test('Deve criar uma língua a partir de um JSON corretamente', () {
      final json = {
        'id': 1,
        'nome': 'Inglês',
        'descricao': 'Idioma falado em muitos países.'
      };

      final lingua = Language.fromJson(json);

      expect(lingua.id, 1);
      expect(lingua.nome, 'Inglês');
      expect(lingua.descricao, 'Idioma falado em muitos países.');
    });

    test('Deve converter uma Língua para JSON corretamente', () {
      final lingua = Language(id: 1, nome: 'Inglês', descricao: 'Idioma falado em muitos países.');

      final json = lingua.toJson();

      expect(json['id'], 1);
      expect(json['nome'], 'Inglês');
      expect(json['descricao'], 'Idioma falado em muitos países.');
    });
  });

  // Testes com Mock (API)
  group('Testes com Mock (API)', () {
    test('Deve retornar uma lista de idiomas ao fazer uma requisição GET', () async {
      final mockLanguages = [
        Language(id: 1, nome: 'Inglês', descricao: 'Idioma falado em muitos países.'),
        Language(id: 2, nome: 'Espanhol', descricao: 'Falado na América Latina.')
      ];

      // Criando o mock do client HTTP
      final client = MockClient();

      // Configurando o mock para retornar uma resposta simulada com os idiomas
      when(() => client.get(Uri.parse('http://localhost:3000/linguas')))
          .thenAnswer((_) async => http.Response(
              json.encode(mockLanguages.map((e) => e.toJson()).toList()), 200));

      // Criando a instância do ApiService com o mockClient
      final apiService = ApiService(client: client);
      final linguas = await apiService.getLinguas();

      // Verificando se os idiomas retornados são os esperados
      expect(linguas.length, 2);
      expect(linguas[0].nome, 'Inglês');
      expect(linguas[1].nome, 'Espanhol');
    });
  });

  // Testes de Widget
  group('Testes de Widget', () {
    testWidgets('Deve exibir a lista de idiomas na tela de listagem', (WidgetTester tester) async {
      final mockLanguages = [
        Language(id: 1, nome: 'Inglês', descricao: 'Idioma falado em muitos países.'),
        Language(id: 2, nome: 'Espanhol', descricao: 'Falado na América Latina.')
      ];

      final client = MockClient();

      when(() => client.get(Uri.parse('http://localhost:3000/linguas')))
          .thenAnswer((_) async => http.Response(
              json.encode(mockLanguages.map((e) => e.toJson()).toList()), 200));

      final apiService = ApiService(client: client);
      final linguas = await apiService.getLinguas();

      await tester.pumpWidget(MaterialApp(
        home: ListScreen(linguas: linguas),
      ));

      // Verificando se os idiomas estão sendo exibidos
      expect(find.text('Inglês'), findsOneWidget);  
      expect(find.text('Espanhol'), findsOneWidget); 
      expect(find.byType(ListTile), findsNWidgets(2));
    });

    testWidgets('Deve navegar para a tela de formulário ao clicar no botão de adicionar', (WidgetTester tester) async {
      final mockLanguages = [
        Language(id: 1, nome: 'Inglês', descricao: 'Idioma falado em muitos países.'),
      ];

      final client = MockClient();

      when(() => client.get(Uri.parse('http://localhost:3000/linguas')))
          .thenAnswer((_) async => http.Response(
              json.encode(mockLanguages.map((e) => e.toJson()).toList()), 200));

      final apiService = ApiService(client: client);
      final linguas = await apiService.getLinguas();

      await tester.pumpWidget(MaterialApp(
        home: ListScreen(linguas: linguas),
      ));

      // Verificando se o botão de adicionar (FloatingActionButton) está presente
      expect(find.byType(FloatingActionButton), findsOneWidget);

      // Simulando um clique no FloatingActionButton (que deveria navegar para a tela de formulário)
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();  // Espera a navegação ser concluída

      // Verifica se o título da tela de formulário foi carregado
      expect(find.text('Adicionar Idioma'), findsOneWidget);
    });
  });
}
