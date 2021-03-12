import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConfig {

  static final _databaseName = "appstore.db";
  static final _databaseVersion = 1;

  DatabaseConfig._privateConstructor();
  static final DatabaseConfig instance = DatabaseConfig._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    await deleteDatabase(path);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    // await db.execute("CREATE TABLE carts(uid TEXT PRIMARY KEY, category TEXT, product_id TEXT, user_id TEXT, processor TEXT, quantity INTEGER)");
    // await db.execute("CREATE TABLE products(uid TEXT PRIMARY KEY, title TEXT, description TEXT, category TEXT, price NUMERIC)");
    await db.execute("CREATE TABLE thumbnails(uid TEXT PRIMARY KEY, image TEXT, pos INTEGER, x INTEGER, y INTEGER);");
  }

  Future<int> insert(Map<String, dynamic> row, table) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }


  Future<List<Map<String, dynamic>>> queryAllRowsByUid(table, Map<String, String> field) async {
    Database db = await instance.database;
    List<String> entries = field.entries.map((e) {
      return ' ${e.key} = ${e.value}';
    }).toList();

    return await db.query(table, where: entries.map((e) => e).toString());
  }

  Future<List<Map<String, dynamic>>> queryAllRows(table) async {
    Database db = await instance.database;

    return await db.query(table);
  }

}