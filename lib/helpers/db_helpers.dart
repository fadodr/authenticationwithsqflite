import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBhelpers {
  static Future<sql.Database> database(String table) async {
    final dbPath = await sql.getDatabasesPath();
    final database = await sql.openDatabase(path.join(dbPath + 'user.db'), onCreate: (db, version){
      return db.execute('CREATE TABLE $table(id TEXT PRIMARY KEY, name TEXT, email TEXT UNIQUE, phone_number VARCHAR(11), profession TEXT, password TEXT)');
    }, version: 1);
    return database;
  }

  static Future<void> insert(String table , Map<String, dynamic> data) async {
    final db = await DBhelpers.database(table);
    await db.rawInsert('INSERT INTO $table(id, name, email, phone_number, profession, password)VALUES("${data['id']}","${data['name']}","${data['email']}", "${data['phone_number']}", "${data['profession']}", "${data['password']}")');
  }

  static Future<List<Map<String , dynamic>>> fetchuser(String table, String email , String password) async {
    final db = await DBhelpers.database(table);
    return db.rawQuery("SELECT * FROM $table WHERE email = '$email' AND password = '$password'");
  }
}