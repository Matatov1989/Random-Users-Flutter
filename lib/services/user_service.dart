import 'package:dio/dio.dart';
import '../models/user.dart';

class UserService {
  final Dio _dio = Dio();

  Future<List<User>> fetchUsers() async {
    final response = await _dio.get('https://randomuser.me/api/?results=10');
    final data = response.data['results'] as List;
    return data.map((user) => User.fromJson(user)).toList();
  }
}
