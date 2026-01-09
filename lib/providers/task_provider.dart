import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/task_model.dart';

class TaskProvider with ChangeNotifier {
  static const String boxName = 'tasksBox';

  List<Task> _tasks = [];
  List<Task> get tasks => _tasks;

  TaskProvider() {
    loadTasks();
  }

  void loadTasks() {
    final box = Hive.box<Task>(boxName);
    _tasks = box.values.toList();
    notifyListeners();
  }

  Future<void> addTask(String title) async {
    final task = Task(title: title);
    await Hive.box<Task>(boxName).add(task);
    _tasks.add(task);
    notifyListeners();
  }

  Future<void> toggleTask(int index) async {
    _tasks[index].isCompleted = !_tasks[index].isCompleted;
    await _tasks[index].save();
    notifyListeners();
  }

  Future<void> deleteTask(int index) async {
    await _tasks[index].delete();
    _tasks.removeAt(index);
    notifyListeners();
  }
}
