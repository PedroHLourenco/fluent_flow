import 'package:flutter/material.dart';
import '../models/language.dart';
import '../models/lesson.dart';
import '../services/api_service.dart';

class FormScreen extends StatefulWidget {
  final String type;

  const FormScreen({super.key, required this.type});

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _title;
  late int _languageId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.type == 'languages' ? 'Adicionar Idioma' : 'Adicionar Lição'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: widget.type == 'languages' ? 'Nome do Idioma' : 'Título da Lição'),
                onChanged: (value) {
                  if (widget.type == 'languages') {
                    _name = value;
                  } else {
                    _title = value;
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              if (widget.type == 'lessons')
                DropdownButtonFormField<int>(
                  decoration: InputDecoration(labelText: 'Idioma'),
                  items: [1, 2] // Exemplo de idiomas disponíveis
                      .map((id) => DropdownMenuItem<int>(
                            value: id,
                            child: Text(id == 1 ? 'Inglês' : 'Espanhol'),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _languageId = value!;
                    });
                  },
                ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      if (widget.type == 'languages') {
                        ApiService().addLanguage(Language(id: 0, name: _name));
                      } else {
                        ApiService().addLesson(Lesson(id: 0, title: _title, languageId: _languageId));
                      }
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Salvar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
