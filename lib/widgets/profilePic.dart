import 'package:flutter/material.dart';
import 'package:happening/constants/basicConsts.dart';
import 'package:happening/models/currentuser.dart';

class ProfilePic extends StatelessWidget {
  @override
  Image build(BuildContext context) {
    CurrentUser c = context.watch<CurrentUser>();
    return Image.network(c.user.image ?? DefaultTexts.defImage);
  }
}
