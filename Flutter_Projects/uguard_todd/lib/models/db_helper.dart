import 'dart:async';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';
import 'package:uguard_app/models/picture.dart';

class DBHelper {

  static Future<Database> database() async {
    var dbPath = await sql.getDatabasesPath();

    return sql.openDatabase(path.join(dbPath, 'pics.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE pic(id TEXT PRIMARY KEY, title TEXT, image TEXT)');
    }, version: 1);
  }

  // static Future<void> insert(String table, Map<String, Object> data) async {
  //   final db = await DBHelper.database();
  //   db.insert(
  //     table,
  //     data,
  //     conflictAlgorithm: ConflictAlgorithm.replace,
  //   );
  // }
static Future<void> insert(String table, Picture pic)async {
  var value={
    'id': DateTime.now().toString(),
    'title':'Profile',
    'image':'fart',
  };
  
    final db = await DBHelper.database();
    db.insert(
      table,
      value,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }
}
