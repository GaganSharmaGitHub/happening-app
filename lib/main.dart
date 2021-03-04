import 'package:flutter/material.dart';
import 'package:happening/screens/router.dart' as R;
import 'package:provider/provider.dart';
import 'package:happening/models/currentuser.dart';
import 'package:happening/screens/navigating/nav.dart';
import 'package:happening/constants/basicConsts.dart';
import 'package:happening/utils/navigate.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final CurrentUser cr = CurrentUser();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => cr,
      child: Builder(builder: (context) {
        return MaterialApp(
          navigatorKey: navigatorService.navigatorKey,
          debugShowCheckedModeBanner: false,
          title: 'Happening',
          theme: ThemeData(
            primarySwatch: Colors.deepPurple,
            accentColor: AppColors.primaryAccent,
            buttonColor: AppColors.primaryAccent,
            buttonTheme: ButtonThemeData(
              buttonColor: AppColors.primaryAccent,
            ),
            cardTheme: CardTheme(elevation: 4),
            indicatorColor: AppColors.primaryAccent,
            primaryColor: AppColors.primary,
            toggleableActiveColor: AppColors.primaryAccent,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: Scaffold(body: SplashScreen()),
        );
      }),
    );
  }
}
