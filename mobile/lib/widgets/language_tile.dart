import 'package:flutter/material.dart';
import '../models/language.dart';

class LanguageTile extends StatelessWidget {
  final Language language;
  final VoidCallback onTap;

  const LanguageTile(Language language, {super.key, required this.language, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(language.name),
      onTap: onTap,
    );
  }
}
