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
    if (_database != null) return _database!;

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
    final data = 'TEXT NOT NULL';

    await db.execute('''
CREATE TABLE $userData ( 
  ${UserFields.data} $data
  )
''');
  }

  Future create(String aba) async {
    final dbb = await db.database;

    // final json = note.toJson();
    // final columns =
    //     '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
    // final values =
    //     '${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';
    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    // row to insert
    Map<String, dynamic> row = {
      "data": aba,
    };

    await dbb.insert(userData, row);

    // Insert some records in a transaction
  }

  Future<List<UserDbModel>> readAllNotes() async {
    final dbb = await db.database;
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');
    final result = await dbb.query(userData);
    print(result);
    return result.map((json) => UserDbModel.fromJson(json)).toList();
  }

  static List<UserDbModel> users = <UserDbModel>[];
  Future getUsers() async {
    users.clear();
    var abbb = await ResultDatabase.db.readAllNotes();

    for (int i = 0; i < abbb.length; i++) {
      print("Read Data $i ${abbb[i]}");
    }
  }

  static Future<List<User>> fetchUsers() async {
    users.clear();
    var abbb = await ResultDatabase.db.readAllNotes();
    var user;
    for (int i = 0; i < 1; i++) {
      print("Read Data $i ${abbb[i]}");
      print("Read DataValue $i ${abbb[i].dbValue}");

      final json = jsonDecode(abbb[i].dbValue);

      print("Read json $json");

      final results = json['results'] as List<dynamic>;

      print("Read results $results");

      user = results.map((e) {
        return User.fromMap(e);
      }).toList();

      print('user2: $user');
    }
    print('user: $user');
    return user;
  }

  // Future<int> delete(int id) async {
  //   final db = await instance.database;

  //   return await db.delete(
  //     amazonCart,
  //     where: '${ProductFields.id} = ?',
  //     whereArgs: [id],
  //   );
  // }
}
