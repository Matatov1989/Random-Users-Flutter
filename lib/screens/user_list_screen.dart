import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_users/providers/user_provider.dart';
import 'package:random_users/screens/user_detail_screen.dart';
import 'package:random_users/widgets/app_bar_widget.dart';

class UserListScreen extends ConsumerStatefulWidget {
  const UserListScreen({super.key});

  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends ConsumerState<UserListScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final usersAsyncValue = ref.watch(userListProvider);

    return Scaffold(
      appBar: AppBarWidget(
        title: 'Users List',
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(userListProvider.notifier).load();
            },
          ),
          PopupMenuButton<int>(
            icon: const Icon(Icons.sort),
            onSelected: (int value) {
              print('Выбрано: $value');
            },
            itemBuilder: (BuildContext context) {
              return <int, String>{0: 'by max age', 1: 'by min age'}.entries.map((entry) {
                return PopupMenuItem<int>(
                  value: entry.key,
                  child: Text(entry.value),
                );
              }).toList();
            },
          ),
        ],
      ),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserDetailScreen(user: user),
                  ),
                )
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
