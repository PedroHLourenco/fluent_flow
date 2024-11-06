import 'package:flutter/material.dart';
import 'form_screen.dart';
import '../models/language.dart';
import '../services/api_service.dart';
import '../components/language_card.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  late Future<List<Language>> linguas;

  @override
  void initState() {
    super.initState();
    linguas = ApiService().getLinguas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Idiomas Disponíveis")),
      body: FutureBuilder<List<Language>>(
        future: linguas,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Erro ao carregar idiomas"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Nenhum idioma disponível"));
          }

          final linguas = snapshot.data!;

          return ListView.builder(
            itemCount: linguas.length,
            itemBuilder: (context, index) {
              return LanguageCard(lingua: linguas[index]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FormScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
