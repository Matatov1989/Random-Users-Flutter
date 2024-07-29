import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:random_users/enums/age_sort.dart';
import '../models/user.dart';
import '../services/user_service.dart';

final userServiceProvider = Provider<UserService>((ref) => UserService());

final userListProvider =
    StateNotifierProvider<UserListNotifier, AsyncValue<List<User>>>((ref) {
  return UserListNotifier(ref.read(userServiceProvider));
});

class UserListNotifier extends StateNotifier<AsyncValue<List<User>>> {
  final UserService _userService;

  UserListNotifier(this._userService) : super(const AsyncLoading()) {
    load();
  }

  Future<void> load() async {
    try {
      final users = await _userService.fetchUsers();
      state = AsyncValue.data(users);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  void sortUsers(AgeSort sortOption) {
    state.whenData((users) {
      List<User> sortedUsers = List.from(users);
      if (sortOption == AgeSort.ageAsc) {
        sortedUsers.sort((user1, user2) =>
            user2.dateOfBirthday.age.compareTo(user1.dateOfBirthday.age));
      } else if (sortOption == AgeSort.ageDesc) {
        sortedUsers.sort((user1, user2) =>
            user1.dateOfBirthday.age.compareTo(user2.dateOfBirthday.age));
      }
      state = AsyncValue.data(sortedUsers);
    });
  }
}
