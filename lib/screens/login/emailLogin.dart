import 'package:flutter/material.dart';
import 'package:happening/api/apiRepo.dart';
import 'package:happening/constants/basicConsts.dart';
import 'package:happening/constants/constants.dart';
import 'package:happening/widgets/basicwidgets.dart';

class LoginEmailScreen extends StatefulWidget {
  LoginEmailScreen({Key key}) : super(key: key);

  @override
  _LoginEmailScreenState createState() => _LoginEmailScreenState();
}

class _LoginEmailScreenState extends State<LoginEmailScreen> {
  String email;
  bool emailxChecked = false;
  bool isLoading = false;
  String message = DefaultTexts.emailnoMessage;
  bool emailIsValid() {
    return emailRegExp.hasMatch(email ?? '');
  }

  updateMessage() {
    if (email == '' || email == null) {
      message = DefaultTexts.emailnoMessage;
      return;
    }
    if (emailIsValid()) {
      message = DefaultTexts.emailvalidMessage;
    } else {
      message = DefaultTexts.emailinvalidMessage;
    }
    setState(() {});
  }

  checkMail() async {
    if (emailxChecked) {
      Navigator.of(context).pushNamed(Routes.LoginPassword, arguments: email);
      return;
    }
    setState(() {
      message = DefaultTexts.emailcheckingMessage;
      isLoading = true;
    });
    try {
      Map<String, String> qu = {'email': email};
      Map result = await ApiRepository().queryUser(qu);
      if (result['success'] == true) {
        if (result['count'] != 0) {
          setState(() {
            message = DefaultTexts.emailgoodMessage;
            emailxChecked = true;
            isLoading = false;
          });
          return;
        } else {
          setState(() {
            isLoading = false;
            message = DefaultTexts.emailnotExistMessage;
          });
          return;
        }
      } else {
        setState(() {
          isLoading = false;
          message = 'error connecting to server';
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        message = e.toString();
      });
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
                  child: LoadingDisabler(
                    isLoading: isLoading,
                    loader: LinearProgressIndicator(),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        AppLogo(
                          size: 50,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(DefaultTexts.emailLoginScreenMessage),
                        SizedBox(
                          height: 30,
                        ),
                        TextField(
                          onChanged: (b) {
                            setState(() {
                              email = b;
                              emailxChecked = false;
                              updateMessage();
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Email',
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
                              emailxChecked ? 'Next' : 'Check',
                            ),
                          ),
                          onPressed: emailIsValid() ? checkMail : null,
                        ),
                      ],
                    ),
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
