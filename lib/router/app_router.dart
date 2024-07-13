import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:random_users/models/user.dart';
import 'package:random_users/screens/user_detail_screen.dart';
import 'package:random_users/screens/user_list_screen.dart';
import 'package:random_users/widgets/app_bar_widget.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return AppBarWidget(child: child);
      },
      routes: <RouteBase>[
        GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) {
            return UserListScreen();
          },
          routes: <RouteBase>[
            GoRoute(
              path: 'user_detail',
              builder: (BuildContext context, GoRouterState state) {
                final user = state.extra as User;
                return UserDetailScreen(user: user);
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
