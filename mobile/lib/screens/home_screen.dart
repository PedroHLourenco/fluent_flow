import 'package:flutter/material.dart';
import 'list_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'FluentFlow',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              color: Colors.blue[100],
              child: ListTile(
                title: Center(
                  child: Text(
                    'Idiomas Matriculados',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/languages');
                },
              ),
            ),
            SizedBox(height: 20),
            Card(
              color: Colors.blue[100],
              child: ListTile(
                title: Center(
                  child: Text(
                    'Lições Iniciadas',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/lessons');
                },
              ),
            ),
          ],
        ),
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
