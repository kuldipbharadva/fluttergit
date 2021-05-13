import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class MyDatabase {
  static final _databaseName = "MyTest.db";

  /* give your database name */
  static final _databaseVersion = 1;

  static final tableTest = 'tbl_test';

  /* give your table name */
  String id = "id";
  String name = "name";
  String city = "city";

  static Database _database;

  MyDatabase._privateConstructor();

  static final MyDatabase instance = MyDatabase._privateConstructor();

  /* this function get instance object of database */
  Future<Database> get database async {
    if (_database == null) {
      _database = await _initDatabase();
    }
    return _database;
  }

  /* this opens the database (and creates it if it doesn't exist) */
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  /* this function create table in database */
  Future _onCreate(Database db, int version) async {
    await db.execute(
        '''CREATE TABLE IF NOT EXISTS $tableTest (Aid INTEGER PRIMARY KEY AUTOINCREMENT,
            $id VARCHAR(20) NOT NULL,
            $name VARCHAR(40) NOT NULL,
            $city VARCHAR(20) NOT NULL)''');
  }

  /* this function insert record in table */
  Future<int> insert(String table, Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  /* this function give list of records from database table */
  Future<List<Map<String, dynamic>>> queryAllRows(String table) async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<List<Map<String, dynamic>>> queryWithWhere(
      String table, String whereCondition) async {
    Database db = await instance.database;
    return await db.query(table, where: whereCondition).catchError((onError) {
      print("onError :: " + onError.toString());
    });
  }

  Future<List<Map<String, dynamic>>> queryWithCondition(
      String table, String fieldName, String fieldValue) async {
    Database db = await instance.database;
    return await db
        .query(table, where: '$fieldName = ?', whereArgs: [fieldValue]);
  }

  /* this function gives you count of records available in table */
  Future<List<Map<String, dynamic>>> queryGetLastRecord(String table, String columnName) async {
    Database db = await instance.database;
    return db.query(table, orderBy: "$columnName DESC", limit: 1);
  }

  /* this function gives you count of records available in table */
  Future<int> queryRowCount(String table) async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  /* this function gives you all the table's name of db */
  getAllTableNames() async {
    Database db = await instance.database;
    var names = db.query('sqlite_master', columns: ['type', 'name']);
    print("all tables name :: " + names.toString());
  }

  /* this function update your record in database */
  Future<int> update(
      String table, Map<String, dynamic> row, String columnName) async {
    Database db = await instance.database;
    // String id = ;
    return await db.update(table, row,
        where: '$columnName = ?', whereArgs: [row[columnName]]);
  }

  /* this function delete specific record from table based on given field name */
  Future<int> delete(String table, String fieldName, String fieldValue) async {
    Database db = await instance.database;
    return await db
        .delete(table, where: '$fieldName = ?', whereArgs: [fieldValue]);
  }

  /* this function delete all the records of given table */
  Future<int> deleteAll(String table) async {
    Database db = await instance.database;
    return await db.delete(table);
  }
}
