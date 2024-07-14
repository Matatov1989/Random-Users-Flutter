import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:random_users/providers/app_bar_provider.dart';
import 'package:random_users/providers/user_provider.dart';


class UserListScreen extends ConsumerStatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends ConsumerState<UserListScreen> {

  @override
  void initState() {
    super.initState();
    _updateAppBar();
  }

  void _updateAppBar() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(appBarProvider.notifier).update(
        'User List',
        [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => ref.read(userListProvider.notifier).load(),
          ),
        ],
        null,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final usersAsyncValue = ref.watch(userListProvider);

    return Scaffold(
      body: usersAsyncValue.when(
        data: (users) => ListView.builder(
          itemCount: users.length,
          itemBuilder: (_, index) {
            final user = users[index];
            return ListTile(
              leading: Image.network(user.pictureUrl),
              title: Text(user.name),
              subtitle: Text(user.email),
              onTap: () => {
                GoRouter.of(context).go('/user_detail', extra: user)
              },
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
