import 'package:flutter/material.dart';
import 'package:happening/api/apiRepo.dart';
import 'package:happening/constants/basicConsts.dart';
import 'package:happening/models/currentuser.dart';

class FollowButton extends StatefulWidget {
  final User user;
  FollowButton(this.user);
  @override
  _FollowButtonState createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
  User user;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    user = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    CurrentUser c = context.watch<CurrentUser>();
    if (isLoading) {
      return MaterialButton(
        child: CircularProgressIndicator(),
        onPressed: null,
      );
    }
    bool isFollowed() {
      for (User u in user.followers) {
        if (u.id == c.user.id) {
          return true;
        }
      }
      return false;
    }

    like() async {
      setState(() {
        isLoading = true;
      });
      try {
        Map resp = await ApiRepository()
            .followUser(authToken: c.authToken, id: user.id);
        if (resp['success'] == true) {
          user.followers.add(c.user);
          c.setUser(User.fromDynamic(resp['data']), c.authToken);
          setState(() {});
        } else {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${resp['reason']}'),
            ),
          );
        }
      } catch (e) {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('$e'),
          ),
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }

    unlike() async {
      setState(() {
        isLoading = true;
      });
      try {
        Map resp = await ApiRepository()
            .unfollowUser(authToken: c.authToken, id: user.id);
        if (resp['success'] == true) {
          user.followers.remove(c.user);
          setState(() {});
        } else {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${resp['reason']}'),
            ),
          );
        }
      } catch (e) {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('$e'),
          ),
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }

    c.user.followers ??= [];
    if (isFollowed()) {
      return RaisedButton(
        onPressed: unlike,
        child: Text('${user.followers.length}following'),
      );
    } else {
      return RaisedButton(
        onPressed: like,
        child: Text('${user.followers.length}follow'),
      );
    }
  }
}
