import 'package:flutter/material.dart';
import 'package:happening/models/currentuser.dart';
import 'package:happening/widgets/user/exuserScreen.dart';
import 'package:happening/widgets/user/myuserScreen.dart';

class UserScreen extends StatelessWidget {
  final User user;
  const UserScreen({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CurrentUser c = context.watch<CurrentUser>();
    return Scaffold(
      body: c.user.id == user.id ? MyUserScreen(user) : ExUserScreen(user),
    );
  }
}
