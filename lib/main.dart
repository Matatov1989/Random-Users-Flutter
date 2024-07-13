import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:random_users/models/user.dart';
import 'package:random_users/screens/user_detail_screen.dart';
import 'package:random_users/screens/user_list_screen.dart';
import 'package:random_users/widgets/app_bar_widget.dart';


void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final GoRouter _router = GoRouter(
      routes: [
        ShellRoute(
          builder: (context, state, child) {
            return AppBarWidget(child: child);
          },
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
        ),
      ],
    );

    return MaterialApp.router(
      routerConfig: _router,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
