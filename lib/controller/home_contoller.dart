import 'package:flutter/material.dart';
import 'package:sqflite_app/database/database_helper.dart';
import 'package:sqflite_app/database/todo_tabel.dart';
import 'package:sqflite_app/models/todo.dart';

class HomeContoller {
  final dbHelper = DatabaseHelper();
  final tbTodo = TodoTabel();
  List<TodoModel> todoList = [];
  TextEditingController judulC = TextEditingController();
  TextEditingController deskripsiC = TextEditingController();
  TextEditingController searchC = TextEditingController();

  Future refreshList() async {
    final todos = await tbTodo.getAllTodo();
    todoList = todos;
  }

  Future addItem() async {
    await tbTodo
        .addTodo(TodoModel(nama: judulC.text, deskripsi: deskripsiC.text));
    refreshList();
    judulC.text = '';
    deskripsiC.text = '';
  }

  Future deleteItem(int id) async {
    await tbTodo.deleteTodo(id);
    refreshList();
  }

  Future updateItem(int index, bool done) async {
    todoList[index].done = done;
    await tbTodo.updateTodo(todoList[index]);
    refreshList();
  }

  Future cariTodo() async {
    String key = searchC.text.trim();
    if (key.isEmpty) {
      todoList = await tbTodo.getAllTodo();
    } else {
      todoList = await tbTodo.getSearchTodo(key);
    }
  }

  void tampilForm(BuildContext context, Function save) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Tambah Todo'),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Tutup')),
                ElevatedButton(
                    onPressed: () {
                      save();
                      Navigator.pop(context);
                    },
                    child: Text('Simpan'))
              ],
              content: Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    TextField(
                      controller: judulC,
                      decoration: InputDecoration(
                        labelText: 'Judul',
                      ),
                    ),
                    TextField(
                      controller: deskripsiC,
                      decoration: InputDecoration(
                        labelText: 'Deksripsi',
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
