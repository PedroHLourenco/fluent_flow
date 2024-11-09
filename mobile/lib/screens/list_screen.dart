import 'package:flutter/material.dart';

class ListScreen extends StatefulWidget {
  final String type;

  ListScreen({required this.type});

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of ${widget.type}'),
      ),
      body: Center(
        child: Text('List of ${widget.type} will be here.'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/languages');
          } else if (index == 2) {
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
