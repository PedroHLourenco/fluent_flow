import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'list_screen.dart';

class FormScreen extends StatefulWidget {
  final String type;

  FormScreen({required this.type});

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  int _currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FluentFlow', textAlign: TextAlign.center),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text('Form to add a new ${widget.type} will be here.'),
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
