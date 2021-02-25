import 'package:flutter/material.dart';
import 'package:happening/api/apiRepo.dart';
import 'package:happening/constants/basicConsts.dart';
import 'package:happening/models/currentuser.dart';
import 'package:happening/models/posts.dart';

class LikeButton extends StatefulWidget {
  final Post post;
  LikeButton(this.post);
  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  Post post;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    post = widget.post;
  }

  @override
  Widget build(BuildContext context) {
    CurrentUser c = context.watch<CurrentUser>();
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    bool isLiked() {
      for (User e in post.likes) {
        if (e.id == c.user.id) return true;
      }
      return false;
    }

    like() async {
      setState(() {
        isLoading = true;
      });
      try {
        Map resp =
            await ApiRepository().likePost(id: post.id, auth: c.authToken);
        if (resp['success'] == true) {
          post.likes.add(c.user);
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
        Map resp =
            await ApiRepository().unlikePost(id: post.id, auth: c.authToken);
        if (resp['success'] == true) {
          post.likes.remove(c.user);
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

    post.likes ??= [];
    if (isLiked()) {
      return InkWell(
        onTap: unlike,
        child: Container(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.star,
                    color: AppColors.primaryAccent,
                  ),
                  Text(post.likes.length.toString())
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return Center(
        child: InkWell(
          onTap: like,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.star_border,
                  color: Colors.grey,
                ),
                Text(post.likes.length.toString())
              ],
            ),
          ),
        ),
      );
    }
  }
}
