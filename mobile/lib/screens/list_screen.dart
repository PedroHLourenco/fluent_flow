import 'package:flutter/material.dart';
import '../models/language.dart';
import '../models/lesson.dart';
import '../services/api_service.dart';
import '../widgets/language_tile.dart';
import '../widgets/lesson_tile.dart';

class ListScreen extends StatelessWidget {
  final String type;

  const ListScreen({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(type == 'languages' ? 'Idiomas' : 'Lições'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<dynamic>>(
          future: type == 'languages' ? ApiService().getLanguages() : ApiService().getLessons(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Erro: ${snapshot.error}'));
            }

            final items = snapshot.data ?? [];

            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                if (type == 'languages') {
                  final language = items[index] as Language;
                  return LanguageTile(
                    language: language,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/lessons', // Navegação para as lições
                      );
                    },
                  );
                } else {
                  final lesson = items[index] as Lesson;
                  return LessonTile(
                    lesson: lesson,
                    onTap: () {
                      // Navegação para detalhes de lição, se necessário
                    },
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
