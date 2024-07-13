import 'package:go_router/go_router.dart';
import 'package:random_users/models/user.dart';
import 'package:random_users/screens/user_detail_screen.dart';
import 'package:random_users/screens/user_list_screen.dart';

GoRouter createRouter() {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => UserListScreen(),
      ),
      GoRoute(
        path: '/user_detail',
        builder: (context, state) {
          final user = state.extra as User;
          return UserDetailScreen(user: user);
        },
      ),
    ],
  );
}
