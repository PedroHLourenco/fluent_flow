import 'package:flutter/material.dart';
import '../models/lesson.dart';

class LessonTile extends StatelessWidget {
  final Lesson lesson;
  final VoidCallback onTap;

  const LessonTile({super.key, required this.lesson, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(lesson.title),
      onTap: onTap,
    );
  }
}
