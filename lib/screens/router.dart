import 'package:flutter/material.dart';
import 'package:happening/constants/routes.dart';
import 'package:happening/models/currentuser.dart';
import 'package:happening/models/posts.dart';
import 'package:happening/screens/navigating/nav.dart';
import 'package:happening/screens/posts/openpost.dart';
import 'package:happening/screens/screens.dart';

class Router {
  Router._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.Splash:
        return MaterialPageRoute(
          builder: (_) {
            return Scaffold(
              body: SplashScreen(),
            );
          },
        );
      case Routes.Welcome:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: WelcomeScreen(),
          ),
        );
      case Routes.Error:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: ErrorScreen(),
          ),
        );
      case Routes.Home:
        if (settings.arguments is List<Post>) {
          return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: HomeScreen(
                feed: settings.arguments,
              ),
            ),
          );
        }
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: ErrorScreen(),
          ),
        );

      case Routes.Login:
        return MaterialPageRoute(
          builder: (_) => LoginEmailScreen(),
        );
      case Routes.LoginPassword:
        return MaterialPageRoute(
          builder: (_) => LoginPasswordScreen(
            email: settings.arguments,
          ),
        );
      case Routes.Register:
        return MaterialPageRoute(
          builder: (_) => RegisterEmailScreen(),
        );
      case Routes.RegisterName:
        return MaterialPageRoute(
          builder: (_) => RegisterNameScreen(
            email: settings.arguments,
          ),
        );
      case Routes.RegisterPassword:
        return MaterialPageRoute(
          builder: (_) {
            Map mp = settings.arguments;
            return RegisterPasswordScreen(
              email: mp['email'],
              name: mp['name'],
            );
          },
        );

      case Routes.PostRegisterImage:
        return MaterialPageRoute(
          builder: (_) {
            return UserAfterRegImage();
          },
        );

      case Routes.Registering:
        return MaterialPageRoute(
          builder: (_) {
            Map mp = settings.arguments;
            return Registering(
              email: mp['email'],
              name: mp['name'],
              password: mp['password'],
            );
          },
        );

      case Routes.TagPost:
        return MaterialPageRoute(
          builder: (_) {
            String mp = settings.arguments;
            return TagsPostScreen(
              query: mp,
            );
          },
        );

      case Routes.UserScreen:
        return MaterialPageRoute(
          builder: (_) {
            User mp = settings.arguments;
            return UserScreen(
              user: mp,
            );
          },
        );

      case Routes.WritePost:
        return MaterialPageRoute(
          builder: (_) {
            if (settings.arguments is Post)
              return CreatePost(
                repost: settings.arguments,
              );
            else
              return CreatePost();
          },
        );

      case Routes.OpenPost:
        return MaterialPageRoute(
          builder: (_) {
            if (settings.arguments is Post)
              return OpenPostScreen(
                post: settings.arguments,
              );
            else
              return Scaffold(
                body: Center(
                  child: Text('No post found'),
                ),
              );
          },
        );
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
