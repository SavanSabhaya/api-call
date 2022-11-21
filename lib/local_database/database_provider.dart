import 'dart:convert';
import 'dart:io';
import 'package:apicall_rest_api/model/user.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'model_class.dart';

class ResultDatabase {
  static Database? _database;
  static final ResultDatabase db = ResultDatabase._init();

  ResultDatabase._init();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDB('user.db');

    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final name = 'TEXT NOT NULL';
    final gender = 'TEXT NOT NULL';
    final email = 'TEXT NOT NULL';
    final phone = 'TEXT NOT NULL';
    final cell = 'TEXT NOT NULL';

    await db.execute('''
CREATE TABLE $userData ( 
  ${UserFields.name} $name,
  ${UserFields.gender} $gender,
  ${UserFields.email} $email,
  ${UserFields.phone} $phone,
  ${UserFields.cell} $cell
  )
''');
  }

  Future create(UserDbModel userDbModel) async {
    final dbb = await db.database;

    await dbb.insert(userData, userDbModel.toJson());

    // Insert some records in a transaction
  }

  Future<int> delete(String email) async {
    final dbb = await db.database;
    return await dbb.delete(
      userData,
      where: '${UserFields.email} = ?',
      whereArgs: [email],
    );
  }

  static Future<List<UserDbModel>> readAllNotes() async {
    final dbb = await db.database;

    final result = await dbb.query(userData);
    print(result);
    return result.map((json) => UserDbModel.fromJson(json)).toList();
  }
}
