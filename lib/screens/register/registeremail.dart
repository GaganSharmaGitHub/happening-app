import 'package:flutter/material.dart';
import 'package:happening/api/apiRepo.dart';
import 'package:happening/constants/basicConsts.dart';
import 'package:happening/constants/constants.dart';
import 'package:happening/widgets/basicwidgets.dart';
import 'package:vibration/vibration.dart';
import 'package:spring/spring.dart';
import 'package:spring/enum.dart';

class RegisterEmailScreen extends StatefulWidget {
  RegisterEmailScreen({Key key}) : super(key: key);

  @override
  _RegisterEmailScreenState createState() => _RegisterEmailScreenState();
}

class _RegisterEmailScreenState extends State<RegisterEmailScreen> {
  String email;
  bool emailxChecked = false;
  bool isLoading = false;
  String message = DefaultTexts.emailnoMessage;
  final _key = GlobalKey<SpringState>();

  bool emailIsValid() {
    return emailRegExp.hasMatch(email ?? '');
  }

  updateMessage() {
    if (email == '' || email == null) {
      _key.currentState.animate(motion: Motion.Play);
      message = DefaultTexts.emailnoMessage;
      return;
    }
    if (emailIsValid()) {
      message = DefaultTexts.emailvalidMessage;
      _key.currentState.animate(
        motion: Motion.Pause,
      );
    } else {
      _key.currentState.animate(motion: Motion.Play);

      message = DefaultTexts.emailinvalidMessage;
    }
    setState(() {});
  }

  checkMail() async {
    if (emailxChecked) {
      Navigator.of(context).pushNamed(Routes.RegisterName, arguments: email);
      return;
    }
    setState(() {
      _key.currentState.animate(
        motion: Motion.Pause,
      );
      message = DefaultTexts.emailcheckingMessage;
      isLoading = true;
    });
    try {
      Map<String, String> qu = {'email': email};
      Map result = await ApiRepository().queryUser(qu);
      if (result['success'] == true) {
        if (result['count'] == 0) {
          FocusScope.of(context).unfocus();
          _key.currentState.animate(
            motion: Motion.Pause,
          );
          setState(() {
            message = DefaultTexts.emailgoodMessage;
            emailxChecked = true;
            isLoading = false;
          });
          return;
        } else {
          if (await Vibration.hasVibrator()) {
            Vibration.vibrate();
          }
          _key.currentState.animate(motion: Motion.Play);

          setState(() {
            isLoading = false;
            message = DefaultTexts.emailExistMessage;
          });
          return;
        }
      } else {
        if (await Vibration.hasVibrator()) {
          Vibration.vibrate(duration: 1);
        }
        _key.currentState.animate(motion: Motion.Play);

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
  void initState() {
    super.initState();
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
                        DefaultTexts.registerScreenMessage,
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
                        Text(DefaultTexts.emailScreenMessage),
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
                        Spring(
                          key: _key,
                          animType: AnimType.Shake,
                          motion: Motion.Pause,
                          animDuration: Duration(milliseconds: 200),
                          animStatus: (status) => AnimationStatus.dismissed,
                          curve: Curves.elasticInOut,
                          child: Text(
                            message,
                            textAlign: TextAlign.center,
                          ),
                        ),
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
