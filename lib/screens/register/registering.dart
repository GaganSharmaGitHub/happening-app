import 'package:flutter/material.dart';
import 'package:happening/api/apiRepo.dart';
import 'package:happening/constants/SPkeys.dart';
import 'package:happening/constants/basicConsts.dart';
import 'package:happening/models/currentuser.dart';
import 'package:happening/widgets/basicwidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Registering extends StatefulWidget {
  final String email;
  final String password;
  final String name;
  const Registering({
    Key key,
    @required this.email,
    @required this.name,
    @required this.password,
  }) : super(key: key);

  @override
  _RegisteringState createState() => _RegisteringState();
}

class _RegisteringState extends State<Registering> {
  String message = DefaultTexts.registeringScreenMessage;
  @override
  void initState() {
    super.initState();
    register();
  }

  Future register() async {
    try {
      CurrentUser c = context.read<CurrentUser>();

      Map mp = await ApiRepository().register(
          email: widget.email, password: widget.password, name: widget.name);
      if (mp['success'] == true) {
        String token = "Bearer ${mp['token']}";
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var setting = await prefs.setString(SPKeys.authToken, token);
        c.setUser(User.fromMap(mp['user']), token);
        if (setting != null) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.Home, (Route<dynamic> route) => false,
              arguments: []);
          Navigator.of(context).pushNamed(Routes.PostRegisterImage);
        }
      } else {
        c.setError(mp['reason'].toString());
        Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.Welcome,
          (Route<dynamic> route) => false,
        );
        Navigator.of(context).pushNamed(Routes.Error);
      }
    } catch (e) {
      //c.setError(e.toString());
      Navigator.of(context).pushNamedAndRemoveUntil(
        Routes.Welcome,
        (Route<dynamic> route) => false,
      );
      Navigator.of(context).pushNamed(Routes.Error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [AnimatedHappLoader(), Text(message)],
        ),
      ),
    );
  }
}
