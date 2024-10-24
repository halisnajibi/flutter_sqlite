import 'package:sqflite/sqflite.dart';
import 'package:sqflite_app/database/database_helper.dart';

import '../models/contact.dart';

class ContactTabel {
  DatabaseHelper database = DatabaseHelper();
  Future<List<ContactModel>> getAllContact() async {
    var dbClient = await database.db;
    var contacts = await dbClient!.query('contacts');
    return contacts.map((t) => ContactModel.fromMap(t)).toList();
  }

  Future<ContactModel?> getBYID(int id) async {
    var dbClient = await database.db;
    var contacts =
        await dbClient!.query('contacts', where: 'id  = ?', whereArgs: ['$id']);
    if (contacts.isNotEmpty) {
      return ContactModel.fromMap(contacts.first);
    }
    return null;
  }

  Future<List<ContactModel>> getSearchContact(String keywoard) async {
    var dbClient = await database.db;
    var contacts = await dbClient!
        .query('contacts', where: 'nama like ?', whereArgs: ['%$keywoard%']);
    return contacts.map((t) => ContactModel.fromMap(t)).toList();
  }

  Future<int> addContact(ContactModel contact) async {
    var dbClient = await database.db;
    return await dbClient!.insert('contacts', contact.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> updateContact(ContactModel contact) async {
    var dbClient = await database.db;
    return await dbClient!.update('contacts', contact.toMap(),
        where: 'id = ?', whereArgs: [contact.id]);
  }

  Future<int> deleteContact(int id) async {
    var dbClient = await database.db;
    return await dbClient!.delete('contacts', where: 'id = ?', whereArgs: [id]);
  }
}
