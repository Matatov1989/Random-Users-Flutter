import 'package:intl/intl.dart';
import 'package:random_users/models/date_of_birthday.dart';

class User {
  final String fullName;
  final String email;
  final String pictureUrl;
  final DateOfBirthday dateOfBirthday;

  User({
    required this.fullName,
    required this.email,
    required this.pictureUrl,
    required this.dateOfBirthday,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      fullName: '${json['name']['first']} ${json['name']['last']}',
      email: json['email'],
      pictureUrl: json['picture']['thumbnail'],
      dateOfBirthday: DateOfBirthday.fromJson(json['dob']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'email': email,
      'pictureUrl': pictureUrl,
      'dob': dateOfBirthday.toMap(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      fullName: map['fullName'],
      email: map['email'],
      pictureUrl: map['pictureUrl'],
      dateOfBirthday: DateOfBirthday.fromMap(map['dob']),
    );
  }

  int get daysToNextBirthday {
    final formatter = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
    final dob = formatter.parse(dateOfBirthday.date);
    final today = DateTime.now();
    DateTime nextBirthday = DateTime(today.year, dob.month, dob.day);

    if (nextBirthday.isBefore(today) || nextBirthday.isAtSameMomentAs(today)) {
      nextBirthday = DateTime(today.year + 1, dob.month, dob.day);
    }

    return nextBirthday.difference(today).inDays;
  }
}
