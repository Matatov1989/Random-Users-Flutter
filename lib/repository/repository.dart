import 'package:dio/dio.dart';
import '../models/user.dart';

class Repository {
  final Dio _dio;

  Repository(this._dio);

  Future<List<User>> fetchUsers() async {
    final response = await _dio.get('https://randomuser.me/api/?results=10');
    final data = response.data['results'] as List;
    return data.map((user) => User.fromJson(user)).toList();
  }
}