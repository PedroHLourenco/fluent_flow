import 'package:flutter/material.dart';
import '../models/language.dart';

class LanguageCard extends StatelessWidget {
  final Language lingua;

  const LanguageCard({required this.lingua});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text(lingua.nome),
        subtitle: Text(lingua.descricao),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            // Deletar idioma
          },
        ),
      ),
    );
  }
}
