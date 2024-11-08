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
      title: 'Idiomas e Lições',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/languages': (context) => const ListScreen(type: 'languages'),
        '/lessons': (context) => const ListScreen(type: 'lessons'),
        '/add/languages': (context) => const FormScreen(type: 'languages'),
        '/add/lessons': (context) => const FormScreen(type: 'lessons'),
      },
    );
  }
}
