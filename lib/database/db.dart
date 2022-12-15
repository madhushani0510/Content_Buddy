import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../model/User.dart';


class Db{
  Db._privateConstructor();
  static final Db instance =Db._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async{
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path =join(documentDirectory.path,'app.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }
  Future _onCreate(Database db,int version) async {
    await db.execute('''
    CREATE TABLE user(
      id INTEGER PRIMARY KEY,
      name TEXT,
      number TEXT,
      email TEXT,
      imgPath TEXT
    )
    ''');
  }

  Future<List<User>> getUsers() async{
    Database db =await instance.database;
    var contacts = await db.query('user', orderBy: 'name');
    List<User> contactList = contacts.isNotEmpty
        ? contacts.map((c) => User.fromMap(c)).toList()
        : [];
    return contactList;
  }
  Future<int> add(User user) async {
    Database db = await instance.database;
    return await db.insert('user', user.toMap());
  }
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete('user',where: "id = ?", whereArgs: [id]);
  }
  Future<int> update(User user) async {
    Database db = await instance.database;
    return await db.update('user', user.toMap(),
        where: "id = ?", whereArgs: [user.id]);
  }

}