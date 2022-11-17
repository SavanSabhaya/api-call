class UserDob {
  final DateTime dob;
  final int age;

  UserDob({
    required this.dob,
    required this.age,
  });
  factory UserDob.fromMap(Map<String, dynamic> json) {
    return UserDob(
      dob: DateTime.parse(json['date']),
      age: json['age'],
    );
  }
}
