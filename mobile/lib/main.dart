import 'package:flutter/material.dart';
import 'screens/list_screen.dart';
import 'screens/form_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Ensino de Idiomas',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey, // Cor mais sofisticada e neutra
        hintColor: Colors
            .orangeAccent, // Cor de destaque para botões e elementos interativos
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: const TextTheme(
          displayLarge: TextStyle(
              fontSize: 28, fontWeight: FontWeight.w700, color: Colors.black),
          displayMedium: TextStyle(
              fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black87),
          bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
        ),
        scaffoldBackgroundColor: Colors.white, // Fundo branco para leveza
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey[200], // Cor mais clara para campos de texto
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueGrey, // Cor de fundo de botão
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 40),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blueGrey, // Cor da AppBar
          elevation: 4,
          titleTextStyle: TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      home: const HomeScreen(),
      routes: {
        '/languages': (context) => const ListScreen(type: 'languages'),
        '/lessons': (context) => const ListScreen(type: 'lessons'),
        '/add': (context) => const FormScreen(type: 'languages'),
      },
    );
  }
}
