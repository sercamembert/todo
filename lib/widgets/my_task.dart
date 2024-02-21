import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/widgets/my_task_category.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';

class MyTask extends StatelessWidget {
  MyTask({
    Key? key,
    required this.title,
    required this.category,
    required this.time,
    required this.isDone,
    required this.id,
  }) : super(key: key);

  final String title;
  final String time;
  final String category;
  final String id;
  final bool isDone;

  void changeTaskStatus(bool? value) {
    FirebaseFirestore.instance
        .collection('Tasks')
        .doc(id)
        .update({'IsDone': !isDone});
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isDone ? 0.6 : 1.0, // Set opacity based on task completion
      child: Row(
        children: [
          // Icon
          MyTaskCategory(category: category),

          const SizedBox(width: 10),
          // Title and Time
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Apply TextDecoration.lineThrough if the task is done
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    decoration: isDone ? TextDecoration.lineThrough : null,
                  ),
                ),
                if (time.isNotEmpty)
                  Text(
                    time,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
              ],
            ),
          ),

          // edit
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Provider.of<TaskProvider>(context, listen: false).setTaskId(id);
              Navigator.pushNamed(
                context,
                '/edit_task',
              );
            },
          ),
          // Checkbox
          Checkbox(
            value: isDone, // You need to manage the state of the checkbox
            onChanged: (bool? value) {
              changeTaskStatus(value);
            },
          ),
        ],
      ),
    );
  }
}
