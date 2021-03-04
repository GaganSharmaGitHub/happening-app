import 'package:happening/constants/basicConsts.dart';
import 'package:flutter/material.dart';
import 'package:happening/constants/constants.dart';
import 'package:happening/models/currentuser.dart';
import 'package:happening/widgets/basicwidgets.dart';
import 'package:happening/api/apiRepo.dart';
import 'package:happening/constants/SPkeys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPasswordScreen extends StatefulWidget {
  final String email;
  LoginPasswordScreen({@required this.email});
  @override
  _LoginPasswordScreenState createState() => _LoginPasswordScreenState();
}

class _LoginPasswordScreenState extends State<LoginPasswordScreen> {
  String password;
  String message = DefaultTexts.passwordMessage;

  updateMessage() {
    if (password == '' || password == null) {
      message = DefaultTexts.passwordMessage;
      setState(() {});
      return;
    }
    message = DefaultTexts.emailvalidMessage;

    setState(() {});
  }

  Future login() async {
    try {
      CurrentUser c = context.read<CurrentUser>();
      Map mp =
          await ApiRepository().login(email: widget.email, password: password);
      print(mp);
      if (mp['success'] == true) {
        String token = "Bearer ${mp['token']}";
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var setting = await prefs.setString(SPKeys.authToken, token);
        c.setUser(User.fromMap(mp['user']), token);
        if (setting != null) {
          navigatorService.removeAllNavigateTo(Routes.Home);
        }
        return;
      } else {
        setState(() {
          message = mp['reason'].toString();
        });
      }
    } catch (e) {
      //c.setError(e.toString());
      navigatorService.removeAllNavigateTo(
        Routes.Welcome,
      );
      navigatorService.navigateTo(Routes.Error);
    }
  }

  checkPassword() async {
    if (password != '' || password != null) {
      login();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        return ScrollableFullScreen(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    BackButton(),
                    Flexible(
                      child: Text(
                        DefaultTexts.loginScreenMessage,
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      AppLogo(
                        size: 50,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(DefaultTexts.passwordScreenMessage),
                      SizedBox(
                        height: 30,
                      ),
                      TextField(
                        onChanged: (b) {
                          setState(() {
                            password = b;
                            updateMessage();
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              gapPadding: 0),
                        ),
                      ),
                      Text(message),
                      SizedBox(
                        height: 30,
                      ),
                      HappButton(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Next',
                          ),
                        ),
                        onPressed: password == '' || password == null
                            ? null
                            : checkPassword,
                      ),
                    ],
                  ),
                ),
                Container(),
                Container(),
                Container(),
              ],
            ),
          ),
        );
      }),
    );
  }
}
