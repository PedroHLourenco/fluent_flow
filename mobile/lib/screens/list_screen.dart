import 'package:flutter/material.dart';
import '../models/language.dart';
import '../services/api_service.dart';

class ListScreen extends StatefulWidget {
  final String type;

  const ListScreen({super.key, required this.type});

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.type == 'languages' ? 0 : 2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.type == 'languages' ? 'Idiomas' : 'Lições'),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<dynamic>>(
          future: widget.type == 'languages' ? ApiService().getLanguages() : ApiService().getLessons(),
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
                if (widget.type == 'languages') {
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          if (index == 0) {
            Navigator.pushNamed(context, '/languages');
          } else if (index == 1) {
            Navigator.pushNamed(context, '/');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/lessons');
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.language, color: _currentIndex == 0 ? Colors.blueAccent : Colors.grey),
            label: 'Idiomas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: _currentIndex == 1 ? Colors.blueAccent : Colors.grey),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book, color: _currentIndex == 2 ? Colors.blueAccent : Colors.grey),
            label: 'Lições',
          ),
        ],
      ),
    );
  }
}
