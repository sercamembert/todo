import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo/database/firestore.dart';
import 'package:todo/widgets/my_button.dart';
import 'package:todo/widgets/my_categories.dart';
import 'package:todo/widgets/my_data_textfield.dart';
import 'package:todo/widgets/my_textfield.dart';
import 'package:todo/widgets/my_time_textfield.dart';

import '../helper/dissplay_message.dart';

class NewTaskPage extends StatelessWidget {
  NewTaskPage({Key? key});
  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeContoller = TextEditingController();

  final FirestoreDatabase database = FirestoreDatabase();

  final TextEditingController newPostController = TextEditingController();

  String selectedCategory = ''; // zmienna przechowująca wybraną kategorię

  void createTask(BuildContext context) {
    if (titleController.text.isEmpty) {
      displayMessageToUser("please enter title", context);
    } else if (selectedCategory.isEmpty) {
      displayMessageToUser("Please select a category", context);
    } else if (dateController.text.isEmpty) {
      displayMessageToUser("Please enter date", context);
    } else {
      database.addTask(
        titleController.text,
        selectedCategory,
        dateController.text,
        timeContoller.text,
      );

      selectedCategory = '';
      titleController.clear();
      dateController.clear();
      timeContoller.clear();
    }
  }

  // Funkcja aktualizująca wybraną kategorię
  void updateSelectedCategory(String category) {
    selectedCategory = category;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(
            "Add New Task",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: IconButton(
                icon: Icon(Icons.close, color: Colors.black),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 50),
        child: Column(
          children: [
            MyTextField(
              hintText: "Task Title",
              obscureText: false,
              controller: titleController,
            ),
            const SizedBox(height: 35),
            MyCategories(
              updateSelectedCategory: updateSelectedCategory,
              activeCategory: selectedCategory,
            ),
            const SizedBox(height: 35),
            Row(
              children: [
                Expanded(
                  child: MyDataTextField(
                    hintText: "Date",
                    controller: dateController,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: MyTimeTextField(
                    hintText: "Time",
                    controller: timeContoller,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 35),
            MyButton(
              onTap: () {
                createTask(context);
              },
              text: "Save",
            )
          ],
        ),
      ),
    );
  }
}
