import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leading;
  final List<Widget>? actions;

  const AppBarWidget({Key? key, required this.title, this.leading, this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      leading: leading,
      actions: actions,
      automaticallyImplyLeading: true,
      backgroundColor: Colors.blue,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      actionsIconTheme: const IconThemeData(
        color: Colors.white,
      ),
      titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
