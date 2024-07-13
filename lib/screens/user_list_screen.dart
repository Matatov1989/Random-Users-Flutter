import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:random_users/models/user.dart';
import 'package:random_users/presenters/user_list_presenter.dart';
import 'package:random_users/repository/repository.dart';
import 'package:random_users/views/user_list_view.dart';

class UserListScreen extends StatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen>
    implements UserListView {
  late UserListPresenter presenter;
  List<User> users = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final Dio dio = Dio();
    final Repository repository = Repository(dio);
    presenter = UserListPresenter(this, repository);
    presenter.fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => presenter.fetchUsers(),
          ),
        ],
      ),
      body: !_isLoading
          ? users.isEmpty
              ? const Center(child: Text('No users found.'))
              : ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return ListTile(
                      leading: Image.network(user.pictureUrl),
                      title: Text(user.name),
                      subtitle: Text(user.email),
                      onTap: () {
                        context.go('/user_detail', extra: user);
                      },
                    );
                  },
                )
          : Center(child: CircularProgressIndicator()),
    );
  }

  @override
  void showUsers(List<User> users) {
    setState(() {
      this.users = users;
    });
  }

  @override
  void showError(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void showLoading() {
    setState(() {
      _isLoading = true;
    });
  }

  @override
  void hideLoading() {
    setState(() {
      _isLoading = false;
    });
  }
}
