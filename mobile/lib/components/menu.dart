import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: const Text("Home"),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          ListTile(
            title: const Text("Lista de Idiomas"),
            onTap: () {
              Navigator.pushNamed(context, '/list');
            },
          ),
        ],
      ),
    );
  }
}
