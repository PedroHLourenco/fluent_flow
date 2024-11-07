import 'package:flutter/material.dart';
import '../models/lesson.dart';

class LessonTile extends StatelessWidget {
  final Lesson lesson;

  const LessonTile({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(lesson.title),
    );
  }
}
