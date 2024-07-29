import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_users/database/user_database.dart';
import 'package:random_users/enums/age_sort.dart';
import '../models/user.dart';
import '../services/user_service.dart';

final userServiceProvider = Provider<UserService>((ref) => UserService());
final userDatabaseProvider =
    Provider<UserDatabase>((ref) => UserDatabase.instance);

final userListProvider =
    StateNotifierProvider<UserListNotifier, AsyncValue<List<User>>>((ref) {
  return UserListNotifier(
      ref.read(userServiceProvider), ref.read(userDatabaseProvider));
});

class UserListNotifier extends StateNotifier<AsyncValue<List<User>>> {
  final UserService _userService;
  final UserDatabase _userDatabase;

  UserListNotifier(this._userService, this._userDatabase)
      : super(const AsyncLoading()) {
    load(false);
  }

  Future<void> load(bool isNewUsers) async {
    List<User> users;
    try {
      if (isNewUsers) {
        users = await _userService.fetchUsers();
        await replaceLocalData(users);
      } else {
        users = await _userDatabase.fetchUsers();
        if (users.isEmpty) {
          users = await _userService.fetchUsers();
          await replaceLocalData(users);
        }
      }

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

  Future<void> replaceLocalData(List<User> users) async {
    await _userDatabase.clearTable();
    for (var user in users) {
      await _userDatabase.insertUser(user);
    }
  }
}
