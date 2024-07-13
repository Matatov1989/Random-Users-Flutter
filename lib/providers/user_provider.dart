import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';
import '../services/user_service.dart';

final userServiceProvider = Provider<UserService>((ref) => UserService());

final userListProvider = StateNotifierProvider<UserListNotifier, AsyncValue<List<User>>>((ref) {
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
}