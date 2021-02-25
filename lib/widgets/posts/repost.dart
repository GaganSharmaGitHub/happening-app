import 'package:flutter/material.dart';
import 'package:happening/api/apiRepo.dart';
import 'package:happening/constants/basicConsts.dart';
import 'package:happening/models/posts.dart';
import 'package:happening/widgets/basicwidgets.dart';
import 'package:happening/widgets/posts/posts.dart';
import 'package:happening/widgets/user/userTile.dart';

class RePostCard extends StatefulWidget {
  final Post initPost;
  RePostCard({Key key, @required this.initPost}) : super(key: key);

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<RePostCard> {
  Post post;
  bool hasData() =>
      post.contents != null && post.author != null && post.author.name != null;
  @override
  void initState() {
    super.initState();
    post = widget.initPost;
    if (!hasData()) ensureData();
  }

  void ensureData() async {
    post = await post.ensureData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (!post.hasData()) return PostSkeleton();
    return Card(
      child: Container(
        decoration:
            BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              UserTile(
                user: post.author,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  post.contents,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                ),
              ),
              if (post.image == null)
                Container()
              else
                Image.network(
                  post.image ?? DefaultTexts.defImage,
                  fit: BoxFit.fitWidth,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
