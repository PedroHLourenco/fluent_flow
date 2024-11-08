import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  final String type;

  const FormScreen({super.key, required this.type});

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
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
        title: Text(widget.type == 'languages' ? 'Adicionar Idioma' : 'Adicionar Lição'),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
          ),
        ],
      ),
      body: Center(
        child: Text(widget.type == 'languages' ? 'Formulário de Idiomas' : 'Formulário de Lições'),
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
