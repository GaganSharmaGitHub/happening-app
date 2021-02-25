import 'package:flutter/material.dart';
import 'package:happening/api/apiRepo.dart';
import 'package:happening/models/posts.dart';
import 'package:happening/widgets/posts/ListOPost.dart';

class TagsPostScreen extends StatefulWidget {
  final String query;
  TagsPostScreen({Key key, this.query}) : super(key: key);

  @override
  _TagsPostScreenState createState() => _TagsPostScreenState();
}

class _TagsPostScreenState extends State<TagsPostScreen> {
  List<Post> feed = [];
  bool loading = true;
  @override
  void initState() {
    super.initState();
    refresh();
  }

  Future<void> refresh() async {
    Map map =
        await ApiRepository().allPosts(query: {'tags': '${widget.query}'});
    loading = true;

    if (map['success'] == true) {
      List temp = [];
      loading = false;

      if (map['data'] is List) temp = map['data'];
      feed = temp.map((e) => Post.fromDynamic(e)).toList();
      setState(() {});
    } else {
      loading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.query}'),
      ),
      body: Builder(builder: (context) {
        return loading
            ? Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: refresh,
                child: ListOPost(
                  posts: feed,
                ));
      }),
    );
  }
}
