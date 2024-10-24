import 'package:sqflite/sqflite.dart';
import 'package:sqflite_app/database/database_helper.dart';

import '../models/todo.dart';

class TodoTabel {
  DatabaseHelper database = DatabaseHelper();
  Future<List<TodoModel>> getAllTodo() async {
    var dbClient = await database.db;
    var todos = await dbClient!.query('todos');
    return todos.map((t) => TodoModel.fromMap(t)).toList();
  }

  Future<List<TodoModel>> getSearchTodo(String keywoard) async {
    var dbClient = await database.db;
    var todos = await dbClient!
        .query('todos', where: 'nama like ?', whereArgs: ['%$keywoard%']);
    return todos.map((t) => TodoModel.fromMap(t)).toList();
  }

  Future<int> addTodo(TodoModel todo) async {
    var dbClient = await database.db;
    return await dbClient!.insert('todos', todo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> updateTodo(TodoModel todo) async {
    var dbClient = await database.db;
    return await dbClient!
        .update('todos', todo.toMap(), where: 'id = ?', whereArgs: [todo.id]);
  }

  Future<int> deleteTodo(int id) async {
    var dbClient = await database.db;
    return await dbClient!.delete('todos', where: 'id = ?', whereArgs: [id]);
  }
}
