import 'package:flutter/material.dart';
import 'package:happening/models/user.dart';

class MyUserScreen extends StatefulWidget {
  final User user;
  MyUserScreen(this.user);
  @override
  _MyUserScreenState createState() => _MyUserScreenState();
}

class _MyUserScreenState extends State<MyUserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('me:${widget.user.name}')),
    );
  }
}
