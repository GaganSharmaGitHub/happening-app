import 'package:flutter/material.dart';
import 'package:happening/constants/basicConsts.dart';
import 'package:happening/models/currentuser.dart';
import 'package:happening/models/posts.dart';
import 'package:happening/services/postService.dart';
import 'package:happening/widgets/basicwidgets.dart';
import 'package:happening/widgets/posts/posts.dart';

class FeedTab extends StatefulWidget {
  final List<Post> initFeed;
  FeedTab({Key key, this.initFeed}) : super(key: key);

  @override
  _FeedTabState createState() => _FeedTabState();
}

class _FeedTabState extends State<FeedTab> {
  List<Post> feed = [];
  @override
  void initState() {
    super.initState();
    if (widget.initFeed == null || widget.initFeed.isEmpty) {
      refresh();
    } else {
      feed = widget.initFeed;
    }
  }

  Future<void> refresh() async {
    CurrentUser c = context.read<CurrentUser>();
    try {
      var resp = await PostServices().feed(c.authToken);
      setState(() {
        feed = resp.feed;
        c.setUser(User.fromDynamic(resp.user), c.authToken);
      });
    } catch (e) {
      c.setError('Error $e');
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('$e'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    CurrentUser c = context.watch<CurrentUser>();

    void createPost(BuildContext ctx, {Post repost}) async {
      var mp = await Navigator.of(ctx)
          .pushNamed(Routes.WritePost, arguments: repost);
      if (mp is Map) {
        if (mp['success'] == true) {
          Post newPost = Post.fromDynamic(mp['data']);
          newPost.author = c.user;
          setState(() {
            feed.insert(0, newPost);
          });
        } else {
          Scaffold.of(ctx).showSnackBar(SnackBar(
            content: Text('Failed to post, ${mp['reason']}'),
          ));
        }
      } else {
        Scaffold.of(ctx).showSnackBar(SnackBar(
          content: Text('Failed to post '),
        ));
      }
    }

    return Scaffold(
      body: Builder(builder: (context) {
        return RefreshIndicator(
          onRefresh: refresh,
          child: ListView.builder(
            itemBuilder: (context, index) {
              if (index == 0) {
                return ListTile(
                  trailing: CircleAvatar(
                    backgroundImage: ProfilePic().build(context).image,
                  ),
                  title: Text('Your feed'),
                );
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                    child: FeedPostCard(
                  key: Key(feed[index - 1].id + 'feedpost'),
                  initPost: feed[index - 1],
                )),
              );
            },
            itemCount: feed.length + 1,
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          createPost(context);
        },
      ),
    );
  }
}
