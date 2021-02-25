import 'package:flutter/material.dart';
import 'package:happening/api/apiRepo.dart';
import 'package:happening/constants/basicConsts.dart';
import 'package:happening/models/currentuser.dart';
import 'package:happening/models/posts.dart';
import 'package:happening/widgets/basicwidgets.dart';
import 'package:happening/widgets/posts/posts.dart';
import 'package:happening/widgets/user/userTile.dart';
import 'package:flutter/material.dart';

class CompletePost extends StatefulWidget {
  final initPost;
  CompletePost({Key key, @required this.initPost}) : super(key: key);

  @override
  _CompletePostState createState() => _CompletePostState();
}

class _CompletePostState extends State<CompletePost> {
  Post post;

  @override
  void initState() {
    super.initState();
    post = widget.initPost;
    ensureData();
  }

  void ensureData() async {
    if (!post.hasData()) post = await post.ensureData();
    setState(() {});
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
    if (!post.hasData()) return PostSkeleton();
    return Container(
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
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
            ),
          ),
          if (post.repost != null)
            InkWell(
              onTap: () {
                Navigator.of(context)
                    .pushNamed(Routes.OpenPost, arguments: post.repost);
              },
              child: RePostCard(
                initPost: post.repost,
              ),
            )
          else
            Container(),
          if (post.image == null)
            Container()
          else
            Image.network(
              post.image,
              fit: BoxFit.fitWidth,
              loadingBuilder: (context, child, loadingProgress) => child,
            ),
          Container(
            decoration:
                BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
            child: Row(
              children: [
                Expanded(child: LikeButton(post)),
                Container(
                  child: SizedBox(
                    width: 0,
                    height: 50,
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey)),
                ),
                Expanded(
                    child: InkWell(
                        onTap: () {
                          createPost(context, repost: post);
                        },
                        child: Icon(Icons.repeat)))
              ],
            ),
          )
        ],
      ),
    );
  }
}
