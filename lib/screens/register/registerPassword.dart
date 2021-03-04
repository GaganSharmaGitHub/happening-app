import 'package:flutter/material.dart';
import 'package:happening/api/apiRepo.dart';
import 'package:happening/constants/basicConsts.dart';
import 'package:happening/widgets/basicwidgets.dart';

class RegisterPasswordScreen extends StatefulWidget {
  final String email;
  final String name;
  RegisterPasswordScreen({@required this.email, @required this.name});
  @override
  _RegisterPasswordScreenState createState() => _RegisterPasswordScreenState();
}

class _RegisterPasswordScreenState extends State<RegisterPasswordScreen> {
  String password;
  String confirmPassword;
  String message = DefaultTexts.passwordMessage;
  bool allOk = false;
  @override
  Widget build(BuildContext context) {
    checkPassword() async {
      setState(() {
        if (!allOk) return;
        navigatorService.removeAllNavigateTo(Routes.Registering, arguments: {
          'name': widget.name,
          'email': widget.email,
          'password': password,
        });
      });
    }

    updateMessage() {
      allOk = false;
      if (password == null || password == '') {
        message = DefaultTexts.passwordMessage;
        return;
      }
      if (password.length < 6) {
        message = DefaultTexts.passinvalidMessage;
        return;
      }
      if (confirmPassword != password) {
        message = DefaultTexts.passnotmatchMessage;
      } else {
        allOk = true;
        message = DefaultTexts.passvalidMessage;
      }
    }

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
                        DefaultTexts.registerScreenMessage,
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
                      SizedBox(
                        height: 30,
                      ),
                      TextField(
                        onChanged: (b) {
                          setState(() {
                            confirmPassword = b;
                            updateMessage();
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
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
                        onPressed: !allOk ? null : checkPassword,
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
