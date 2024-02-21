import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'dart:math';

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
      'IsDone': false,
    });
  }

  //update task
  Future<void> updateTask(
    String taskId,
    String title,
    String category,
    String date,
    String time,
  ) async {
    try {
      await tasks.doc(taskId).update({
        'Title': title,
        'Category': category,
        'Date': date,
        'Time': time,
      });
    } catch (error) {
      throw error;
    }
  }

  // read not completed tasks from database
  Stream<QuerySnapshot> getUncompletedTasksStream() {
    DateTime now = DateTime.now();
    String currentDateString = DateFormat('d/M/yyyy').format(DateTime.now());

    final uncompletedTasksStream = FirebaseFirestore.instance
        .collection("Tasks")
        .where('UserEmail', isEqualTo: user!.email)
        .where('Date', isEqualTo: currentDateString)
        .where('IsDone', isEqualTo: false)
        .snapshots();

    return uncompletedTasksStream;
  }

  // read completed tasks from database
  Stream<QuerySnapshot> getCompletedTasksStream() {
    DateTime now = DateTime.now();
    String currentDateString = DateFormat('d/M/yyyy').format(DateTime.now());

    final completedTasksStream = FirebaseFirestore.instance
        .collection("Tasks")
        .where('UserEmail', isEqualTo: user!.email)
        .where('Date', isEqualTo: currentDateString)
        .where('IsDone', isEqualTo: true)
        .snapshots();

    return completedTasksStream;
  }

  // get task by id
  Future<DocumentSnapshot> getTaskById(String taskId) async {
    try {
      DocumentSnapshot taskSnapshot = await tasks.doc(taskId).get();
      return taskSnapshot;
    } catch (error) {
      throw error;
    }
  }
}
