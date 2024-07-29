class DateOfBirthday {
  final String date;
  final int age;

  DateOfBirthday({
    required this.date,
    required this.age,
  });

  factory DateOfBirthday.fromJson(Map<String, dynamic> json) {
    return DateOfBirthday(
      date: json['date'],
      age: json['age'],
    );
  }
}
