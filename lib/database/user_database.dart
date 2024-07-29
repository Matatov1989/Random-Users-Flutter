import 'package:sqflite/sqflite.dart';

import '../models/user.dart';

class UserDatabase {
  static final UserDatabase instance = UserDatabase._init();

  static Database? _database;

  UserDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('users.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = '$dbPath/$fileName';

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const userTable = '''
    CREATE TABLE users (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      fullName TEXT,
      email TEXT,
      pictureUrl TEXT,
      date TEXT,
      age INTEGER
    )
    ''';

    await db.execute(userTable);
  }

  Future<void> insertUser(User user) async {
    final db = await instance.database;

    await db.insert(
      'users',
      {
        'fullName': user.fullName,
        'email': user.email,
        'pictureUrl': user.pictureUrl,
        'date': user.dateOfBirthday.date,
        'age': user.dateOfBirthday.age,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<User>> fetchUsers() async {
    final db = await instance.database;

    final result = await db.query('users');

    return result
        .map((json) => User.fromMap({
              'fullName': json['fullName'],
              'email': json['email'],
              'pictureUrl': json['pictureUrl'],
              'dob': {
                'date': json['date'],
                'age': json['age'],
              },
            }))
        .toList();
  }

  Future<void> clearTable() async {
    final db = await instance.database;
    await db.delete('users');
  }
}
