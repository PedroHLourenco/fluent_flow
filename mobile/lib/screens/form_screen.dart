import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/language.dart';

class FormScreen extends StatefulWidget {
  final String type; // 'languages' ou 'lessons'

  const FormScreen({super.key, required this.type});

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _controller = TextEditingController();
  String _selectedLanguage = '';
  bool _isLoading = false;
  List<Language> _languages = [];

  @override
  void initState() {
    super.initState();
    if (widget.type == 'lessons') {
      _fetchLanguages();
    }
  }

  Future<void> _fetchLanguages() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final languages = await ApiService().fetchLanguages();
      setState(() {
        _languages = languages;
        if (languages.isNotEmpty) {
          _selectedLanguage = languages[0].id.toString();
        }
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erro ao carregar idiomas')));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _addLanguage() async {
    final name = _controller.text;
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Digite o nome do idioma')));
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await ApiService().addLanguage(name);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Idioma Adicionado')));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erro ao adicionar idioma')));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _addLesson() async {
    final title = _controller.text;
    if (title.isEmpty || _selectedLanguage.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Preencha todos os campos')));
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await ApiService().addLesson(title, int.parse(_selectedLanguage));
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Lição Adicionada')));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erro ao adicionar lição')));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.type == 'languages'
            ? 'Adicionar Idioma'
            : 'Adicionar Lição'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Card(
          elevation: 6,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          shadowColor: Colors.indigo.withOpacity(0.2),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: widget.type == 'languages'
                        ? 'Nome do Idioma'
                        : 'Título da Lição',
                  ),
                ),
                const SizedBox(height: 16),
                if (widget.type == 'lessons') ...[
                  _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : DropdownButton<String>(
                          isExpanded: true,
                          value: _selectedLanguage.isEmpty
                              ? null
                              : _selectedLanguage,
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedLanguage = newValue!;
                            });
                          },
                          items: _languages
                              .map((Language language) =>
                                  DropdownMenuItem<String>(
                                    value: language.id.toString(),
                                    child: Text(language.name),
                                  ))
                              .toList(),
                        ),
                ],
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _isLoading
                      ? null
                      : widget.type == 'languages'
                          ? _addLanguage
                          : _addLesson,
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(widget.type == 'languages'
                          ? 'Adicionar Idioma'
                          : 'Adicionar Lição'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
