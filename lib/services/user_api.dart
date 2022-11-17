import 'dart:convert';
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
    const url = 'https://randomuser.me/api/?results=5';
    final uri = Uri.parse(url);
    var response = await http.get(uri);

    var jsonString = response.body;

    ResultDatabase.db.create(jsonString.toString());

    final json = jsonDecode(jsonString);
    final results = json['results'] as List<dynamic>;
    final user = results.map((e) {
      return User.fromMap(e);
    }).toList();
    return user;
  }
}
