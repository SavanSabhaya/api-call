import 'dart:convert';

List<UserDbModel> welcomeFromJson(String str) => List<UserDbModel>.from(
    json.decode(str).map((x) => UserDbModel.fromJson(x)));

String welcomeToJson(List<UserDbModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserDbModel {
  UserDbModel(
      {required this.name,
      required this.gender,
      required this.email,
      required this.phone,
      required this.cell});

  final String name;
  final String gender;
  final String email;
  final String phone;
  final String cell;

  factory UserDbModel.fromJson(Map<String, dynamic> json) => UserDbModel(
        name: json["name"],
        gender: json["gender"],
        email: json["email"],
        phone: json["phone"],
        cell: json["cell"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "gender": gender,
        "email": email,
        "phone": phone,
        "cell": cell,
      };
}

final String userData = 'userData';

class UserFields {
  static final List<String> values = [name, gender, email, phone, cell];

  static final String name = 'name';
  static final String gender = 'gender';
  static final String email = 'email';
  static final String phone = 'phone';
  static final String cell = 'cell';
}
