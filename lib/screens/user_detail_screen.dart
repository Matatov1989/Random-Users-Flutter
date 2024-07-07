import 'package:flutter/material.dart';
import 'package:random_users/models/user.dart';
import '../views/user_detail_view.dart';

class UserDetailScreen extends StatelessWidget implements UserDetailView {
  final User user;

  UserDetailScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(user.pictureUrl),
            SizedBox(height: 16),
            Text(
              user.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              user.email,
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void showUserDetails(User user) {
    // We already have the user details via constructor, no additional implementation needed.
  }
}