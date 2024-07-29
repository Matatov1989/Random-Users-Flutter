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

  factory DateOfBirthday.fromMap(Map<String, dynamic> map) {
    return DateOfBirthday(
      date: map['date'],
      age: map['age'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'age': age,
    };
  }
}
