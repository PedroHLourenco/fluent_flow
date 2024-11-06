import 'package:flutter/material.dart';
import '../models/language.dart';
import '../services/api_service.dart';

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _nomeController = TextEditingController();
  final _descricaoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Adicionar Idioma")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(labelText: "Nome do Idioma"),
            ),
            TextField(
              controller: _descricaoController,
              decoration: const InputDecoration(labelText: "Descrição"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final lingua = Language(
                  id: DateTime.now().millisecondsSinceEpoch,
                  nome: _nomeController.text,
                  descricao: _descricaoController.text,
                );
                ApiService().postLinguas(lingua);
                Navigator.pop(context);
              },
              child: const Text("Adicionar Idioma"),
            ),
          ],
        ),
      ),
    );
  }
}
