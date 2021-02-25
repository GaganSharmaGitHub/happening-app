import 'package:flutter/material.dart';
import 'package:happening/constants/basicConsts.dart';

class AppLogo extends StatelessWidget {
  final double size;
  const AppLogo({Key key, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CircleAvatar(
        minRadius: size,
        child: Icon(
          Icons.bookmark,
          size: size,
        ),
      ),
    );
  }
}
