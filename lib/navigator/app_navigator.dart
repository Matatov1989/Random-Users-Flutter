import 'package:flutter/material.dart';
import 'package:random_users/models/user.dart';
import 'package:random_users/screens/user_detail_screen.dart';
import 'package:random_users/screens/user_list_screen.dart';

class AppNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case '/':
            builder = (BuildContext _) => UserListScreen();
            break;
          case '/user_detail':
            final user = settings.arguments as User;
            builder = (BuildContext _) => UserDetailScreen(user: user);
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}