import 'dart:convert';

List<UserDbModel> welcomeFromJson(String str) => List<UserDbModel>.from(
    json.decode(str).map((x) => UserDbModel.fromJson(x)));

String welcomeToJson(List<UserDbModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserDbModel {
  UserDbModel({
    required this.dbValue,
  });

  String dbValue;

  factory UserDbModel.fromJson(Map<String, dynamic> json) => UserDbModel(
        dbValue: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "data": dbValue,
      };
}

final String userData = 'userdata';

class UserFields {
  static final List<String> values = [data];

  static final String data = 'data';
}
