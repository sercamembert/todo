import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/widgets/my_button.dart';
import 'package:todo/widgets/my_task.dart';

import '../database/firestore.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key});

  void logout() async {
    FirebaseAuth.instance.signOut();
  }

  final FirestoreDatabase database = FirestoreDatabase();

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('MMMM dd, yyyy').format(DateTime.now());

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(
            formattedDate,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: logout,
              icon: const Icon(
                Icons.logout_rounded,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // To do Title
              Center(
                child: const Text(
                  "My Todo List",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ),
              const SizedBox(height: 20),
              // Display not completed tasks
              StreamBuilder(
                stream: database.getUncompletedTasksStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final tasks = snapshot.data!.docs;

                  if (snapshot.data == null || tasks.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text("There are no tasks to do"),
                      ),
                    );
                  }

                  // Return list of not completed tasks
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: tasks.map<Widget>((post) {
                      String title = post['Title'];
                      String category = post['Category'];
                      String time = post['Time'];
                      bool isDone = post['IsDone'];

                      return Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: MyTask(
                          category: category,
                          title: title,
                          time: time,
                          isDone: isDone,
                          id: post.id,
                        ),
                      );
                    }).toList(),
                  );
                },
              ),

              //completed tasks
              const Text(
                "Completed",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),

              const SizedBox(height: 10),
              // Display completed tasks
              StreamBuilder(
                stream: database.getCompletedTasksStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final tasks = snapshot.data!.docs;

                  if (snapshot.data == null || tasks.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text("You haven't completed any task yet"),
                      ),
                    );
                  }

                  // Return list of completed tasks
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: tasks.map<Widget>((post) {
                      String title = post['Title'];
                      String category = post['Category'];
                      String time = post['Time'];
                      bool isDone = post['IsDone'];

                      return Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: MyTask(
                          category: category,
                          title: title,
                          time: time,
                          isDone: isDone,
                          id: post.id,
                        ),
                      );
                    }).toList(),
                  );
                },
              ),

              MyButton(
                onTap: () {
                  Navigator.pushNamed(context, '/create_new_task');
                },
                text: "New Task",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
