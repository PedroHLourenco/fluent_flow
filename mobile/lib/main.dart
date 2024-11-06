import 'package:flutter/material.dart';
import 'screens/dashboard.dart';
import 'screens/list_screen.dart';
import 'screens/form_screen.dart';
import 'components/menu.dart';

void main() {
  runApp(FluentFlow());
}

class FluentFlow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Language Learning App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => DashboardScreen(),
        '/list': (context) => ListScreen(),
        '/form': (context) => FormScreen(),
      },
    );
  }
}
