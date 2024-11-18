import 'package:flutter/material.dart';
import '../models/language.dart';
import '../models/lesson.dart';

class ListScreen extends StatelessWidget {
  final String type;

  const ListScreen({required this.type});

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;
    final int? languageId = arguments is int ? arguments : null;

    final List items = type == 'languages'
        ? [
            Language(id: 1, name: 'Inglês'),
            Language(id: 2, name: 'Espanhol'),
          ]
        : [
            Lesson(id: 1, title: 'Saudações em Inglês', languageId: 1),
            Lesson(id: 2, title: 'Frases comuns em Espanhol', languageId: 2),
          ].where((lesson) => lesson.languageId == languageId).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'FluentFlow',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          if (type == 'languages') {
            final Language item = items[index];
            return ListTile(
              title: Text(item.name),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/lessons',
                  arguments: item.id,
                );
              },
            );
          } else {
            final Lesson item = items[index];
            return ListTile(
              title: Text(item.title),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            type == 'languages' ? '/add/languages' : '/add/lessons',
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: type == 'languages' ? 1 : 2,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.blue,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/');
          } else if (index == 1 && type != 'languages') {
            Navigator.pushReplacementNamed(context, '/languages');
          } else if (index == 2 && type != 'lessons') {
            Navigator.pushReplacementNamed(context, '/lessons');
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.language),
            label: 'Idiomas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Lições',
          ),
        ],
      ),
    );
  }
}
