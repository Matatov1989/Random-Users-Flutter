import 'package:random_users/models/user.dart';

abstract class UserListView {
  void showUsers(List<User> users);
  void showError(String message);
  void showLoading();
  void hideLoading();
}