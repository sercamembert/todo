import 'package:flutter/material.dart';

class MyDataTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  const MyDataTextField({
    Key? key,
    required this.hintText,
    required this.controller,
  }) : super(key: key);

  @override
  _MyDataTextFieldState createState() => _MyDataTextFieldState();
}

class _MyDataTextFieldState extends State<MyDataTextField> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        widget.controller.text =
            "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.hintText,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        const SizedBox(height: 3),
        TextField(
          controller: widget.controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.secondary),
            ),
            hintText: widget.hintText,
            filled: true,
            fillColor: Colors.white,
            suffixIcon: IconButton(
              icon: Icon(
                Icons.calendar_today,
                color: Theme.of(context).colorScheme.primary,
              ),
              onPressed: () => _selectDate(context),
            ),
          ),
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}
