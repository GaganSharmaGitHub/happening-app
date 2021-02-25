import 'package:flutter/cupertino.dart';
import 'package:happening/models/user.dart';
export 'package:provider/provider.dart';
export 'package:happening/models/user.dart';

class CurrentUser extends ChangeNotifier {
  Status logStatus = Status.checking;
  User user;
  String authToken;
  String errorMessage = 'keep happening';
  CurrentUser();
  User setUser(User u, String auth) {
    user = u;
    if (auth != null) authToken = auth;

    logStatus = Status.loggedin;
    notifyListeners();
    return user;
  }

  String setError(String str) {
    logStatus = Status.error;
    errorMessage = str;
    notifyListeners();
    return str;
  }
}

enum Status { checking, loggedin, loggedout, error }
