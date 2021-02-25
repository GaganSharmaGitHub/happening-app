import 'package:flutter/material.dart';
import 'package:happening/constants/basicConsts.dart';
import 'package:happening/widgets/basicwidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileTab extends StatefulWidget {
  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          FlatButton(
            child: Text('image'),
            onPressed: () =>
                Navigator.of(context).pushNamed(Routes.PostRegisterImage),
          ),
          ClipOval(
            child: SizedBox(
              child: ProfilePic(),
              height: 200,
            ),
          ),
          FlatButton(
            child: Text('logout'),
            onPressed: () async {
              SharedPreferences pref = await SharedPreferences.getInstance();
              pref.clear().then(
                  (value) => Navigator.of(context).pushNamed(Routes.Splash));
            },
          ),
        ],
      ),
    );
  }
}
