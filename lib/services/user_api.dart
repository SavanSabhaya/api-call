import 'dart:convert';
import 'package:apicall_rest_api/local_database/model_class.dart';
import 'package:apicall_rest_api/model/user.dart';
import 'package:http/http.dart' as http;

import '../local_database/database_provider.dart';

// class UseraApi {
//   static Future<List<User>> fetchUsers() async {
//     print('fetchUsers called');
//     const url = 'https://randomuser.me/api/?results=5';
//     final uri = Uri.parse(url);
//     var response = await http.get(uri);
//     var body = response.body;
//     final json = jsonDecode(body);
//     final results = json['results'] as List<dynamic>;
//     final user = results.map((e) {
//       return User.fromMap(e);
//     }).toList();
//     return user;
//   }
// }
class UseraApi {
  static Future<List<User>> fetchUsers() async {
    print('fetchUsers called');
    const url = 'https://randomuser.me/api/?results=25';
    final uri = Uri.parse(url);
    var response = await http.get(uri);

    var jsonString = response.body;

    final json = jsonDecode(jsonString);
    final results = json['results'] as List<dynamic>;
    final user = results.map((e) {
      return User.fromMap(e);
    }).toList();

    // for (int i = 0; i < user.length; i++) {
    //   ResultDatabase.db.create(UserDbModel(
    //     name: user[i].fullname,
    //     gender: user[i].gender,
    //     email: user[i].email,
    //     phone: user[i].phone,
    //     cell: user[i].cell,
    //   ));
    // }

    return user;
  }
}
