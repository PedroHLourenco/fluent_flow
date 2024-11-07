import 'package:flutter/material.dart';
import '../models/language.dart';

class LanguageTile extends StatelessWidget {
  final Language language;

  const LanguageTile({super.key, required this.language});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(language.name),
    );
  }
}
