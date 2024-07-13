
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppBarState {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;

  AppBarState({required this.title, this.actions, this.leading});
}

class AppBarNotifier extends StateNotifier<AppBarState> {
  AppBarNotifier() : super(AppBarState(title: 'User List'));

  void updateTitle(String title) {
    state = AppBarState(title: title, actions: state.actions, leading: state.leading);
  }

  void updateActions(List<Widget>? actions) {
    state = AppBarState(title: state.title, actions: actions, leading: state.leading);
  }

  void updateLeading(Widget? leading) {
    state = AppBarState(title: state.title, actions: state.actions, leading: leading);
  }

  void update(String title, List<Widget>? actions, Widget? leading) {
    state = AppBarState(title: title, actions: actions, leading: leading);
  }
}

final appBarProvider = StateNotifierProvider<AppBarNotifier, AppBarState>((ref) {
  return AppBarNotifier();
});
