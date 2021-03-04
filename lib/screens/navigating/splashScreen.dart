import 'package:flutter/material.dart';
import 'package:happening/models/currentuser.dart';
import 'package:happening/models/user.dart';
import 'package:happening/services/postService.dart';
import 'package:happening/widgets/animatedLoader.dart';
import 'package:provider/provider.dart';
import 'package:happening/constants/basicConsts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:happening/constants/SPkeys.dart';
import 'package:happening/api/apiRepo.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    isLoggedIn();
  }

  Future login(String auth) async {
    CurrentUser c = context.read<CurrentUser>();
    try {
      var t = await PostServices().feed(auth);
      c.setUser(User.fromDynamic(t.user), auth);
      navigatorService.removeAllNavigateTo(Routes.Home, arguments: t.feed);
    } catch (e) {
      c.setError('Sorry we could not log you in.... ${e}');

      navigatorService.removeAllNavigateTo(
        Routes.Welcome,
      );
      navigatorService.navigateTo(Routes.Error);
    }
  }

  Future logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear().then((value) {
      navigatorService.removeAllNavigateTo(Routes.Welcome);
    });
  }

  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var authToken = prefs.get(SPKeys.authToken);
    print(authToken);
    if (authToken == '' || authToken == null) {
      logOut();
      return false;
    } else {
      try {
        login(authToken);
      } catch (e) {
        CurrentUser c = context.watch<CurrentUser>();
        c.setError(e.message);

        navigatorService.removeAllNavigateTo(
          Routes.Welcome,
        );
        navigatorService.navigateTo(Routes.Error);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: AnimatedHappLoader(),
    ));
  }
}
