import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/list_screen.dart';
import 'screens/form_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Language Learning App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/languages': (context) => ListScreen(type: 'languages'),
        '/lessons': (context) => ListScreen(type: 'lessons'),
        '/add/languages': (context) => FormScreen(type: 'languages'),
        '/add/lessons': (context) => FormScreen(type: 'lessons'),
      },
    );
  }
}
