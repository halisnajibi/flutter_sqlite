import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return db;
  }

  Future<Database> initDb() async {
    io.Directory docDirectroy = await getApplicationDocumentsDirectory();
    String path = join(docDirectroy.path, 'todolist.db');
    var localDb = await openDatabase(path,
        version: 3, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return localDb;
  }

  void _onCreate(Database database, int version) async {
    await database.execute('''CREATE TABLE todos (
id INTEGER PRIMARY KEY,
 nama TEXT not null,
 deskripsi TEXT not null,
 done INTEGER not null  default 0)''');

    await database.execute('''
      CREATE TABLE contacts (
        id INTEGER PRIMARY KEY,
        nama TEXT NOT NULL,
        nomor TEXT NOT NULL
      )
    ''');
  }

  void _onUpgrade(Database database, int oldVersion, int newVersion) async {
    if (oldVersion < 3) {
      await database.execute('''
      CREATE TABLE contacts (
        id INTEGER PRIMARY KEY,
        nama TEXT NOT NULL,
        nomor TEXT NOT NULL
      )
    ''');
    }
  }

  // Future<List<TodoModel>> getAllTodo() async {
  //   var dbClient = await db;
  //   var todos = await dbClient!.query('todos');
  //   return todos.map((t) => TodoModel.fromMap(t)).toList();
  // }

  // Future<List<TodoModel>> getSearchTodo(String keywoard) async {
  //   var dbClient = await db;
  //   var todos = await dbClient!
  //       .query('todos', where: 'nama like ?', whereArgs: ['%$keywoard%']);
  //   return todos.map((t) => TodoModel.fromMap(t)).toList();
  // }

  // Future<int> addTodo(TodoModel todo) async {
  //   var dbClient = await db;
  //   return await dbClient!.insert('todos', todo.toMap(),
  //       conflictAlgorithm: ConflictAlgorithm.replace);
  // }

  // Future<int> updateTodo(TodoModel todo) async {
  //   var dbClient = await db;
  //   return await dbClient!
  //       .update('todos', todo.toMap(), where: 'id = ?', whereArgs: [todo.id]);
  // }

  // Future<int> deleteTodo(int id) async {
  //   var dbClient = await db;
  //   return await dbClient!.delete('todos', where: 'id = ?', whereArgs: [id]);
  // }
}
