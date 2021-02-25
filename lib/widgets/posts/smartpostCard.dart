import 'package:flutter/material.dart';
import 'package:happening/api/apiRepo.dart';
import 'package:happening/constants/basicConsts.dart';
import 'package:happening/models/posts.dart';
import 'package:happening/widgets/basicwidgets.dart';
import 'package:happening/widgets/posts/posts.dart';
import 'package:happening/widgets/user/userTile.dart';

class SmartPostCard extends StatefulWidget {
  final Post initPost;
  final Widget child;
  SmartPostCard({Key key, @required this.initPost, @required this.child})
      : super(key: key);

  @override
  _SmartPostCardState createState() => _SmartPostCardState();
}

class _SmartPostCardState extends State<SmartPostCard> {
  Post post;
  bool hasData() =>
      post.contents != null && post.author != null && post.author.name != null;
  @override
  void initState() {
    super.initState();
    post = widget.initPost;
    if (!post.hasData()) ensureData();
  }

  void ensureData() async {
    post = await post.ensureData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (!hasData()) return PostSkeleton();
    return Container(child: widget.child);
  }
}
