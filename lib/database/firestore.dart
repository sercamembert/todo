import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class FirestoreDatabase {
  User? user = FirebaseAuth.instance.currentUser;

  final CollectionReference tasks =
      FirebaseFirestore.instance.collection("Tasks");

  Future<void> addTask(
    String title,
    String category,
    String date,
    String time,
  ) {
    return tasks.add({
      'UserEmail': user!.email,
      'Title': title,
      'Category': category,
      "Date": date,
      'Time': time,
      'IsDone': false
    });
  }

  // read not completed tasks from database
  Stream<QuerySnapshot> getUncompletedTasksStream() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy').format(now);

    final uncompletedTasksStream = FirebaseFirestore.instance
        .collection("Tasks")
        .where('UserEmail', isEqualTo: user!.email)
        .where('Date', isEqualTo: formattedDate)
        .where('IsDone', isEqualTo: false)
        .snapshots();

    return uncompletedTasksStream;
  }

  // read completed tasks from database
  Stream<QuerySnapshot> getCompletedTasksStream() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy').format(now);

    final completedTasksStream = FirebaseFirestore.instance
        .collection("Tasks")
        .where('UserEmail', isEqualTo: user!.email)
        .where('Date', isEqualTo: formattedDate)
        .where('IsDone', isEqualTo: true)
        .snapshots();

    return completedTasksStream;
  }
}
