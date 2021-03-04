import 'package:flutter/material.dart';
import 'package:happening/constants/routes.dart';
import 'package:happening/models/currentuser.dart';
import 'package:happening/models/posts.dart';
import 'package:happening/screens/navigating/nav.dart';
import 'package:happening/screens/posts/openpost.dart';
import 'package:happening/screens/screens.dart';

final _NavigationService navigatorService = _NavigationService();

class _NavigationService {
  _NavigationService();
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;
  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState
        .push(_generateRoute(name: routeName, arguments: arguments));
  }

  Future<dynamic> removeAllNavigateTo(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState.pushAndRemoveUntil(
        _generateRoute(name: routeName, arguments: arguments),
        (route) => false);
  }

  void pop([dynamic arg]) {
    navigatorKey.currentState.pop(arg);
  }

  Route<dynamic> _routify(Widget widget) => MaterialPageRoute(
        builder: (_) {
          return Scaffold(
            body: widget,
          );
        },
      );

  Route<dynamic> _generateRoute({String name, dynamic arguments}) =>
      _routify(_generateWidget(arguments: arguments, name: name));

  Widget _generateWidget({String name, dynamic arguments}) {
    switch (name) {
      case Routes.Splash:
        return SplashScreen();
      case Routes.Welcome:
        return WelcomeScreen();
      case Routes.Error:
        return ErrorScreen();
      case Routes.Home:
        if (arguments is List<Post>) {
          return HomeScreen(
            feed: arguments,
          );
        }
        return HomeScreen();
      case Routes.Login:
        return LoginEmailScreen();
      case Routes.LoginPassword:
        return LoginPasswordScreen(
          email: '$arguments',
        );
      case Routes.Register:
        return RegisterEmailScreen();
      case Routes.RegisterName:
        return RegisterNameScreen(
          email: arguments,
        );
      case Routes.RegisterPassword:
        if (arguments is Map)
          return RegisterPasswordScreen(
            email: arguments['email'],
            name: arguments['name'],
          );
        return ErrorScreen();
      case Routes.PostRegisterImage:
        return UserAfterRegImage();

      case Routes.Registering:
        if (arguments is Map)
          return Registering(
            email: arguments['email'],
            name: arguments['name'],
            password: arguments['password'],
          );
        return ErrorScreen();
      case Routes.TagPost:
        return TagsPostScreen(
          query: arguments,
        );

      case Routes.UserScreen:
        return (arguments is User)
            ? UserScreen(
                user: arguments,
              )
            : ErrorScreen();

      case Routes.WritePost:
        return CreatePost(
          repost: (arguments is Post) ? arguments : null,
        );

      case Routes.OpenPost:
        if (arguments is Post)
          return OpenPostScreen(
            post: arguments,
          );
        return Scaffold(
          body: Center(
            child: Text('No route defined for $name'),
          ),
        );
      default:
        return Scaffold(
          body: Center(
            child: Text('No route defined for $name'),
          ),
        );
    }
  }
}
