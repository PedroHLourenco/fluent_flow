import 'package:flutter/material.dart';
import 'package:mobile/services/api_service.dart';
import 'package:mobile/models/language.dart';

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _controller = TextEditingController();
  int _selectedLanguage = 0;
  bool _isLoading = false;
  List<Language> _languages = [];

  @override
  void initState() {
    super.initState();
    _loadLanguages();
  }

  Future<void> _loadLanguages() async {
    try {
      final languages = await ApiService().getLanguages();
      setState(() {
        _languages = languages;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao carregar idiomas')));
    }
  }

  Future<void> _addLesson() async {
    final title = _controller.text;
    if (title.isEmpty || _selectedLanguage == 0) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Preencha todos os campos')));
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await ApiService().addLesson(title, _selectedLanguage);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Lição Adicionada')));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao adicionar lição')));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Adicionar Lição')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Título da Lição'),
            ),
            DropdownButton<int>(
              isExpanded: true,
              value: _selectedLanguage == 0 ? null : _selectedLanguage,
              onChanged: (int? newValue) {
                setState(() {
                  _selectedLanguage = newValue!;
                });
              },
              items: _languages
                  .map((Language language) => DropdownMenuItem<int>(
                        value: language.id,
                        child: Text(language.name),
                      ))
                  .toList(),
            ),
            SizedBox(height: 20),
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: _addLesson,
                    child: Text('Adicionar Lição'),
                  ),
          ],
        ),
      ),
    );
  }
}
