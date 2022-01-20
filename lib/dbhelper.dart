import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databasename = "persons.db";
  static const _databaseversion = 1;

  static const table = "BillBook";
  static const columnId = 'id';
  static const columnName = "name";
  static const columnAge = "age";
  //static Image person_photo = Image.asset('assets/images/person-logo.png');
  static const columnMonthlyRent = "monthlyrent";
  static const columnRentGiven = "givenrent";

  static Database? _database;

  //so that the class has many objects but only one instance
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentdirectory = await getApplicationDocumentsDirectory();
    // ignore: avoid_print
    print('db location in emulator:' + documentdirectory.path);
    String path = join(documentdirectory.path, _databasename);
    return await openDatabase(path,
        version: _databaseversion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table(
        $columnId INTEGER PRIMARY KEY,
        $columnName TEXT NOT NULL,
        $columnAge INTEGER NOT NULL,
        $columnMonthlyRent INTEGER NOT NULL,
        $columnRentGiven INTEGER
      )
      ''');
  }

  //function for curd operations

  //1.INSERT DATA
  Future<int?> insert(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db?.insert(table, row);
  }

  //2.QUERY ALL DATA
  Future<List<Map<String, dynamic>>?> queryall() async {
    Database? db = await instance.database;
    return await db?.query(table);
  }

  //3.QUERY SPECIFIC DATA
  Future<List<Map<String, dynamic>>?> queryspecific(
      String age, String rentGiven) async {
    Database? db = await instance.database;
    var result = await db?.query(table,
        where: "age > ? and givenrent = ?", whereArgs: [age, rentGiven]);
    return result;
  }

  Future<int?> deletedata(int id) async {
    Database? db = await instance.database;
    var res = await db?.delete(table, where: "id = ?", whereArgs: [id]);
    return res;
  }
}
