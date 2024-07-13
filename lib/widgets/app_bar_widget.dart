import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_users/providers/app_bar_provider.dart';

class AppBarWidget extends ConsumerWidget {
  final Widget? child;

  const AppBarWidget({required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appBarState = ref.watch(appBarProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarState.title),
        actions: appBarState.actions,
        leading: appBarState.leading,
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        actionsIconTheme: const IconThemeData(
          color: Colors.white,
        ),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
      ),
      body: child,
    );
  }
}
