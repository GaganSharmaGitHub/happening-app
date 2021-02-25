import 'package:flutter/material.dart';
import 'package:happening/models/posts.dart';
import 'package:happening/widgets/posts/posts.dart';

class ListOPost extends StatelessWidget {
  final List<Post> posts;
  ListOPost({@required this.posts});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return !true
              ? PostSkeleton()
              : Card(
                  child: FeedPostCard(
                  initPost: posts[index],
                ));
        },
        itemCount: posts.length,
      ),
    );
  }
}
