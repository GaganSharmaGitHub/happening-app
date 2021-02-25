import 'package:flutter/material.dart';
import 'package:happening/api/apiRepo.dart';
import 'package:happening/models/tag.dart';
import 'package:happening/services/postService.dart';
import 'package:happening/widgets/StrmBldr.dart';
import 'package:happening/widgets/trending/trending.dart';

class ExploreTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StrmBldr<List<TagTrending>>(
          stream: PostServices().trendingTags().asStream(),
          builder: (context, snapshot) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  SizedBox(height: 150, child: TagsTrend(tags: snapshot)),
                ],
              ),
            );
          }),
    );
  }
}
