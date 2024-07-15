import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(appBarProvider.notifier).updateAppBar('Users List', [
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () => ref.read(userListProvider.notifier).load(),
        ),
      ]);
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
                Navigator.pushNamed(context, '/user_detail', arguments: user)
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
