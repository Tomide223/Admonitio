import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:collection';
import 'package:todoey_flutter/models/tasks.dart';

class TaskData extends ChangeNotifier {
  final List<Task> _tasks = [];
  late Database _database;

  int get taskCount {
    return _tasks.length;
  }

  Future<void> initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'tasks.db');
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE tasks(id INTEGER PRIMARY KEY, name TEXT, isDone INTEGER,done INTEGER)',
        );
      },
    );
  }

  Future<void> loadData() async {
    await initDatabase();
    final tasksData = await _database.query('tasks');
    _tasks.clear();
    _tasks.addAll(tasksData.map((taskMap) => Task.fromMap(taskMap)));
    notifyListeners();
  }

  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }

  Future<void> addTask(String newTaskTitle) async {
    final task = Task(name: newTaskTitle);
    _tasks.add(task);
    await _database.insert('tasks', task.toMap());
    notifyListeners();
  }

  Future<void> checkTask(Task task) async {
    task.isDone = !task.isDone;
    await _database
        .update('tasks', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
    notifyListeners();
  }

  Future<void> deleteTask(Task task) async {
    _tasks.remove(task);
    await _database.delete('tasks', where: 'id = ?', whereArgs: [task.id]);
    notifyListeners();
  }
}
