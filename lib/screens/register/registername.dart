import 'package:happening/constants/basicConsts.dart';
import 'package:flutter/material.dart';
import 'package:happening/constants/constants.dart';
import 'package:happening/models/currentuser.dart';
import 'package:happening/widgets/basicwidgets.dart';
import 'package:spring/spring.dart';
import 'package:spring/enum.dart';

class RegisterNameScreen extends StatefulWidget {
  final String email;
  RegisterNameScreen({@required this.email});
  @override
  _RegisterNameScreenState createState() => _RegisterNameScreenState();
}

class _RegisterNameScreenState extends State<RegisterNameScreen> {
  String name;
  String message = DefaultTexts.nameMessage;
  final _key = GlobalKey<SpringState>();

  updateMessage() {
    if (name == '' || name == null) {
      _key.currentState.animate(
        motion: Motion.Play,
      );
      message = DefaultTexts.nameMessage;
      setState(() {});
      return;
    }
    message = DefaultTexts.namevalidMessage;
    _key.currentState.animate(
      motion: Motion.Pause,
    );
    setState(() {});
  }

  checkName() async {
    if (name != '' || name != null) {
      navigatorService.navigateTo(
        Routes.RegisterPassword,
        arguments: {'email': widget.email, 'name': name},
      );
      return;
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
                      Text(DefaultTexts.nameScreenMessage),
                      SizedBox(
                        height: 30,
                      ),
                      TextField(
                        onChanged: (b) {
                          setState(() {
                            name = b;
                            updateMessage();
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Name',
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
                        animStatus: (status) => null,
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
                            'Next',
                          ),
                        ),
                        onPressed:
                            name == '' || name == null ? null : checkName,
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
