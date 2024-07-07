import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:random_users/screens/user_detail_screen.dart';
import 'package:random_users/screens/user_list_screen.dart';
import 'models/user.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final GoRouter _router = GoRouter(
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

    return MaterialApp.router(
      title: 'User List App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: _router,
    );
  }
}