import 'package:flutter/material.dart';
import 'package:happening/models/currentuser.dart';
import 'package:provider/provider.dart';
import 'package:happening/constants/basicConsts.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CurrentUser c = context.watch<CurrentUser>();
    return Scaffold(
      body: Container(
        child: Text('ERROR:' + '${c.errorMessage}'),
      ),
    );
  }
}
