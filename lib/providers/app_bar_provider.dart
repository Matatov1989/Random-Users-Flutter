import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppBarState {
  final String title;
  final List<Widget> actions;
  final Widget? leading;

  AppBarState({required this.title, required this.actions, this.leading});
}

class AppBarNotifier extends StateNotifier<AppBarState> {
  AppBarNotifier()
      : super(AppBarState(title: 'Home Screen', actions: [], leading: null));

  void updateAppBar(String title, List<Widget> actions, {Widget? leading}) {
    state = AppBarState(title: title, actions: actions, leading: leading);
  }
}

final appBarProvider =
    StateNotifierProvider<AppBarNotifier, AppBarState>((ref) {
  return AppBarNotifier();
});
