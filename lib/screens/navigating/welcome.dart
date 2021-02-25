import 'package:flutter/material.dart';
import 'package:happening/constants/basicConsts.dart';
import 'package:happening/widgets/basicwidgets.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    gotoLogin() {
      Navigator.of(context).pushNamed(Routes.Login);
    }

    gotoRegister() {
      Navigator.of(context).pushNamed(Routes.Register);
    }

    return ScrollableFullScreen(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppLogo(
              size: 50,
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              DefaultTexts.welcomeMessage,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 40),
            ),
            SizedBox(
              height: 30,
            ),
            HappButton(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              onPressed: gotoLogin,
            ),
            SizedBox(
              height: 30,
            ),
            HappButton(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Register',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              onPressed: gotoRegister,
            ),
          ],
        ),
      ),
    );
  }
}
