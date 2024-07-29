import 'package:random_users/models/date_of_birthday.dart';

class User {
  final String name;
  final String email;
  final String pictureUrl;
  final DateOfBirthday dateOfBirthday;

  User({
    required this.name,
    required this.email,
    required this.pictureUrl,
    required this.dateOfBirthday,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: '${json['name']['first']} ${json['name']['last']}',
      email: json['email'],
      pictureUrl: json['picture']['thumbnail'],
      dateOfBirthday: DateOfBirthday.fromJson(json['dob']),
    );
  }
}
