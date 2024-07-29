import 'package:intl/intl.dart';
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
    // required this.daysToNextBirthday,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: '${json['name']['first']} ${json['name']['last']}',
      email: json['email'],
      pictureUrl: json['picture']['thumbnail'],
      dateOfBirthday: DateOfBirthday.fromJson(json['dob']),
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
