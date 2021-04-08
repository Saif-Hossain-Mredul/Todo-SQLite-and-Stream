import 'dart:async';
import 'dart:io';

import 'package:my_app_part1_and_part2/utilities/task-model.utilities.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();
  static Database _db;

  DatabaseHelper._instance();

  String taskTable = 'task_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDate = 'date';
  String colPriority = 'priority';
  String colStatus = 'status';

  Future<Database> get db async {
    if (_db == null) {
      _db = await _initDB();
    }

    return _db;
  }

  Future<Database> _initDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'todo_list.db';

    final todoListDB =
        await openDatabase(path, version: 1, onCreate: _createDB);
  }

  void _createDB(Database db, int version) async {
    await db.execute('''CREATE TABLE $taskTable(
                $colId INTEGER PRIMARY KEY AUTOINCREMENT, 
                $colTitle TEXT, 
                $colDate TEXT, 
                $colPriority TEXT, 
                $colStatus INTEGER
        )''');
  }

  Future<List> getTaskMapList() async {
    Database db = await this.db;

    final List result = await db.query(taskTable);

    ///TODO: see the results by printing it.
    ///print(result)

    return result;
  }

  Future<List<Task>> getTaskList() async {
    final taskMapList = await getTaskMapList();

    final List<Task> tasksList = [];

    taskMapList.forEach((taskMap) {
      tasksList.add(Task.fromMap(taskMap));
    });

    return tasksList;
  }

  Future insertTask(Task task) async {
    Database db = await this.db;

    final result = await db.insert(taskTable, task.toMap());

    ///TODO: see the results by printing it.
    ///print(result)

    return result;
  }

  Future updateTask(Task task) async {
    Database db = await this.db;

    final result = await db.update(
      taskTable,
      task.toMap(),
      where: '$colId = ?',
      whereArgs: [task.id],
    );

    return result;
  }

  Future deleteTask(int id) async {
    Database db = await this.db;
    final result =
        await db.delete(taskTable, where: '$colId = ?', whereArgs: [id]);

    return result;
  }
}
