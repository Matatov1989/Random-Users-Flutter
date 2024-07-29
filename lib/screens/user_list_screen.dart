import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_users/enums/age_sort.dart';
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
              ref.read(userListProvider.notifier).load(true);
            },
          ),
          PopupMenuButton<AgeSort>(
            icon: const Icon(Icons.sort),
            onSelected: (AgeSort value) {
              print('Выбрано: $value');
              ref.read(userListProvider.notifier).sortUsers(value);
            },
            itemBuilder: (BuildContext context) {
              return <AgeSort, String>{
                AgeSort.ageAsc: 'by max age',
                AgeSort.ageDesc: 'by min age'
              }.entries.map((entry) {
                return PopupMenuItem<AgeSort>(
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
              title: Text(user.fullName),
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
