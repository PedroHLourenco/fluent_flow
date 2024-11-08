import 'package:flutter/material.dart';
import '../models/language.dart';
import '../services/api_service.dart';

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
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      title: Text(language.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      leading: const Icon(Icons.language, color: Colors.indigo),
                      onTap: () {},
                    ),
                  );
                } else {
                  final lesson = items[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      title: Text(lesson.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      leading: const Icon(Icons.book, color: Colors.blueAccent),
                      onTap: () {},
                    ),
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
