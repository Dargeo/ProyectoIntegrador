import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:risknt/models/users.dart';
import 'package:risknt/screens/home/user_tile.dart';
import 'package:risknt/screens/screen_number/PageData.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {

    final users = Provider.of<List<Users>>(context) ?? [];


    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context,index) {
        return PageData(user: users[index]);
      },
    );
  }
}