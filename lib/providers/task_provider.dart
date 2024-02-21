import 'package:flutter/material.dart';

class TaskProvider extends ChangeNotifier {
  String? taskId;

  void setTaskId(String id) {
    taskId = id;
    notifyListeners();
  }
}
