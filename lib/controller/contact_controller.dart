import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sqflite_app/database/contact_tabel.dart';
import 'package:sqflite_app/database/database_helper.dart';
import 'package:sqflite_app/models/contact.dart';

class ContactController {
  final dbHelper = DatabaseHelper();
  final tbContact = ContactTabel();
  List<ContactModel> contacts = [];
  TextEditingController namaC = TextEditingController();
  TextEditingController nomorC = TextEditingController();

  Future refreshList() async {
    final contact = await tbContact.getAllContact();
    contacts = contact;
    return contact;
  }

  Future<ContactModel?> getBYID(int id) async {
    return await tbContact.getBYID(id);
  }

  Future addItem() async {
    await tbContact
        .addContact(ContactModel(nama: namaC.text, nomor: nomorC.text));
    refreshList();
    namaC.text = '';
    nomorC.text = '';
  }

  Future deleteItem(int id) async {
    await tbContact.deleteContact(id);
    refreshList();
  }

  Future updateItem(int id) async {
    await tbContact.updateContact(
        ContactModel(id: id, nama: namaC.text, nomor: nomorC.text));

    refreshList();
  }

  // Future cariTodo() async {
  //   String key = searchC.text.trim();
  //   if (key.isEmpty) {
  //     todoList = await tbTodo.getAllTodo();
  //   } else {
  //     todoList = await tbTodo.getSearchTodo(key);
  //   }
  // }
}
