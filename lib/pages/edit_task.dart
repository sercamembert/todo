import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/database/firestore.dart';
import 'package:todo/providers/task_provider.dart';
import 'package:todo/widgets/my_button.dart';
import 'package:todo/widgets/my_categories.dart';
import 'package:todo/widgets/my_data_textfield.dart';
import 'package:todo/widgets/my_textfield.dart';
import 'package:todo/widgets/my_time_textfield.dart';

import '../helper/dissplay_message.dart';

class EditTaskPage extends StatefulWidget {
  EditTaskPage({Key? key}) : super(key: key);

  @override
  _EditTaskPageState createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  final FirestoreDatabase database = FirestoreDatabase();
  String selectedCategory = '';
  late String taskId;

  @override
  void initState() {
    super.initState();
    // Pobierz taskId z dostawcy
    taskId = Provider.of<TaskProvider>(context, listen: false).taskId ?? '';
    // Jeśli taskId nie jest pusty, pobierz zadanie z bazy danych
    if (taskId.isNotEmpty) {
      database.getTaskById(taskId).then((taskSnapshot) {
        // Ustaw wartości kontrolerów na podstawie danych pobranych z bazy danych
        setState(() {
          titleController.text = taskSnapshot['Title'];
          dateController.text = taskSnapshot['Date'];
          timeController.text = taskSnapshot['Time'];
          selectedCategory = taskSnapshot['Category'];
        });
      }).catchError((error) {
        print("Błąd pobierania danych zadania: $error");
      });
    }
  }

  void updateTask(BuildContext context) {
    if (titleController.text.isEmpty) {
      displayMessageToUser("please enter title", context);
    } else if (selectedCategory.isEmpty) {
      displayMessageToUser("Please select a category", context);
    } else if (dateController.text.isEmpty) {
      displayMessageToUser("Please enter date", context);
    } else {
      database.updateTask(
        taskId,
        titleController.text,
        selectedCategory,
        dateController.text,
        timeController.text,
      );

      selectedCategory = '';
      titleController.clear();
      dateController.clear();
      timeController.clear();

      Navigator.of(context).pop();
    }
  }

  // Funkcja aktualizująca wybraną kategorię
  void updateSelectedCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: const Text(
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
                icon: const Icon(Icons.close, color: Colors.black),
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
                    controller: timeController,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 35),
            MyButton(
              onTap: () {
                updateTask(context);
              },
              text: "Save",
            )
          ],
        ),
      ),
    );
  }
}
