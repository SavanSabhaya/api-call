import 'package:apicall_rest_api/model/user_dob.dart';
import 'package:apicall_rest_api/model/user_location.dart';
import 'package:apicall_rest_api/model/user_name.dart';
import 'package:apicall_rest_api/model/user_picture.dart';

class User {
  final String gender;
  final UserName name;
  final UserLocation location;
  final String email;
  final UserDob dob;
  final String phone;
  final String cell;
  final UserPicture picture;
  final String nat;

  User(
      {required this.picture,
      required this.location,
      required this.dob,
      required this.name,
      required this.gender,
      required this.email,
      required this.phone,
      required this.cell,
      required this.nat});

  factory User.fromMap(Map<String, dynamic> json) {
    final name = UserName.fromMap(json['name']);
    final dob = UserDob.fromMap(json['dob']);
    final location = UserLocation.fromMap(json['location']);
    final picture = UserPicture.fromMap(json['picture']);
    return User(
      gender: json['gender'],
      email: json['email'],
      phone: json['phone'],
      cell: json['cell'],
      nat: json['nat'],
      name: name,
      dob: dob,
      location: location,
      picture: picture,
    );
  }

  String get fullname {
    return '${name.title} ${name.first}  ${name.last}';
  }

  String get photo {
    return '${picture.thumbnail}${picture.large}${picture.medium}';
  }
}
