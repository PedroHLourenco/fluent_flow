import 'package:flutter/material.dart';
import '../models/language.dart';
import '../models/lesson.dart';
import 'form_screen.dart';

class ListScreen extends StatefulWidget {
  final String type;
  ListScreen({required this.type});

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<Language> languages = [
    Language(id: 1, name: 'Inglês'),
    Language(id: 2, name: 'Espanhol'),
  ];

  List<Lesson> lessons = [
    Lesson(id: 1, title: 'Saudações em Inglês', languageId: 1),
    Lesson(id: 2, title: 'Frases comuns em Espanhol', languageId: 2),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            widget.type == 'languages' ? 'Idiomas Matriculados' : 'Lições Iniciadas',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        itemCount: widget.type == 'languages' ? languages.length : lessons.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(widget.type == 'languages'
                ? languages[index].name
                : lessons[index].title),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FormScreen(type: widget.type),
            ),
          );
        },
        backgroundColor: Colors.blue,
        child: Text(
          widget.type == 'languages' ? 'Novo idioma' : 'Nova lição',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.type == 'languages' ? 1 : 2,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/');
          } else if (index == 1 && widget.type != 'languages') {
            Navigator.pushReplacementNamed(context, '/languages');
          } else if (index == 2 && widget.type != 'lessons') {
            Navigator.pushReplacementNamed(context, '/lessons');
          }
        },
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.language),
            label: 'Languages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Lessons',
          ),
        ],
      ),
    );
  }
}
