import 'package:flutter/material.dart';
import 'package:flutter_skeleton/flutter_skeleton.dart';
import 'package:happening/constants/basicConsts.dart';
import 'package:happening/models/currentuser.dart';
import 'package:happening/models/posts.dart';
import 'package:happening/widgets/posts/completePost.dart';
import 'package:happening/widgets/posts/posts.dart';
import 'package:happening/widgets/user/userTile.dart';

class OpenPostScreen extends StatefulWidget {
  final Post post;
  OpenPostScreen({Key key, this.post}) : super(key: key);

  @override
  _OpenPostScreenState createState() => _OpenPostScreenState();
}

class _OpenPostScreenState extends State<OpenPostScreen> {
  Post post;

  @override
  void initState() {
    super.initState();
    post = widget.post;
    ensureData();
  }

  void ensureData() async {
    if (!post.hasData()) post = await post.ensureData();
    setState(() {});
  }

  List<UserTile> likes() {
    post.likes ??= [];
    return post.likes.map<UserTile>((e) => UserTile(user: e)).toList();
  }

  void createPost(BuildContext ctx, {Post repost}) async {
    CurrentUser c = context.read<CurrentUser>();

    var mp =
        await Navigator.of(ctx).pushNamed(Routes.WritePost, arguments: repost);
    if (mp is Map) {
      if (mp['success'] == true) {
        Post newPost = Post.fromDynamic(mp['data']);
        newPost.author = c.user;
      } else {
        Scaffold.of(ctx).showSnackBar(SnackBar(
          content: Text('Failed to post, ${mp['reason']}'),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Builder(builder: (context) {
        if (!post.hasData()) return PostSkeleton();
        return ListView(
          children: [
            CompletePost(
              initPost: post,
            ),
            ...likes()
          ],
        );
      }),
    );
  }
}
