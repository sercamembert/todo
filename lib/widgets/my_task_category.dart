import 'package:flutter/material.dart';

class MyTaskCategory extends StatelessWidget {
  const MyTaskCategory({super.key, required this.category});
  final String category;

  @override
  Widget build(BuildContext context) {
    if (category == "Learning") {
      return const CircleAvatar(
        backgroundColor: Color(0xFFDBECF6),
        radius: 24,
        child: Icon(
          Icons.article_outlined,
          color: Color(0xFF194A66),
          size: 30,
        ),
      );
    } else if (category == "Time") {
      return const CircleAvatar(
        backgroundColor: Color(0xFFE7E2F3),
        radius: 24,
        child: Icon(
          Icons.calendar_month_outlined,
          color: Color(0xFF4A3780),
          size: 30,
        ),
      );
    } else {
      return const CircleAvatar(
        backgroundColor: Color(0xFFFEF5D3),
        radius: 24,
        child: Icon(
          Icons.directions_run,
          color: Color(0xFF403100),
          size: 30,
        ),
      );
    }
  }
}
