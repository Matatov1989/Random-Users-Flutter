import 'package:random_users/repository/repository.dart';
import 'package:random_users/views/user_list_view.dart';



class UserListPresenter {
  final UserListView view;
  final Repository repository;

  UserListPresenter(this.view, this.repository);

  Future<void> fetchUsers() async {
    view.showLoading();
    try {
      final users = await repository.fetchUsers();
      view.showUsers(users);
    } catch (e) {
      view.showError('Failed to load users');
    } finally {
      view.hideLoading();
    }
  }

  // Future<void> fetchUsers() async {
  //   view.showLoading();
  //   try {
  //     final response = await _dio.get('https://randomuser.me/api/?results=10');
  //     final data = response.data['results'] as List;
  //     final users = data.map((user) => User.fromJson(user)).toList();
  //     view.showUsers(users);
  //   } catch (e) {
  //     view.showError('Failed to load users');
  //   } finally {
  //     view.hideLoading();
  //   }
  // }
}