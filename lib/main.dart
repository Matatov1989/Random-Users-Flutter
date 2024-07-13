import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:random_users/router/app_router.dart';


void main() {
  final router = createRouter();
  runApp(ProviderScope(child: MyApp(router: router)));
}

class MyApp extends StatelessWidget {

  final GoRouter router;

  MyApp({required this.router});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
    );
  }
}
