import 'package:flutter/material.dart';

class MyCategories extends StatefulWidget {
  final void Function(String) updateSelectedCategory;
  final String activeCategory;

  const MyCategories({
    Key? key,
    required this.updateSelectedCategory,
    required this.activeCategory,
  }) : super(key: key);

  @override
  _MyCategoriesState createState() => _MyCategoriesState();
}

class _MyCategoriesState extends State<MyCategories> {
  String _localActiveCategory = '';

  @override
  void initState() {
    super.initState();
    _localActiveCategory = widget.activeCategory;
  }

  void _changeActiveCategory(String category) {
    setState(() {
      _localActiveCategory = category;
    });
    widget.updateSelectedCategory(category);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          "Category",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        const SizedBox(width: 20),
        GestureDetector(
          onTap: () {
            _changeActiveCategory("Learning");
          },
          child: Opacity(
            opacity: _localActiveCategory == "Learning" ? 0.5 : 1.0,
            child: CircleAvatar(
              backgroundColor: Color(0xFFDBECF6),
              radius: 24,
              child: Icon(
                Icons.article_outlined,
                color: Color(0xFF194A66),
                size: 30,
              ),
            ),
          ),
        ),
        const SizedBox(width: 20),
        GestureDetector(
          onTap: () {
            _changeActiveCategory("Time");
          },
          child: Opacity(
            opacity: _localActiveCategory == "Time" ? 0.5 : 1.0,
            child: CircleAvatar(
              backgroundColor: Color(0xFFE7E2F3),
              radius: 24,
              child: Icon(
                Icons.calendar_month_outlined,
                color: Color(0xFF4A3780),
                size: 30,
              ),
            ),
          ),
        ),
        const SizedBox(width: 20),
        GestureDetector(
          onTap: () {
            _changeActiveCategory("Workout");
          },
          child: Opacity(
            opacity: _localActiveCategory == "Workout" ? 0.5 : 1.0,
            child: CircleAvatar(
              backgroundColor: Color(0xFFFEF5D3),
              radius: 24,
              child: Icon(
                Icons.directions_run,
                color: Color(0xFF403100),
                size: 30,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
