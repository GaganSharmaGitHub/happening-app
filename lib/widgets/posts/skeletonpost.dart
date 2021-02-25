import 'package:flutter/material.dart';
import 'package:flutter_skeleton/flutter_skeleton.dart';

class PostSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CardSkeleton(
        style: SkeletonStyle(
          theme: SkeletonTheme.Light,
          isShowAvatar: true,
          isCircleAvatar: true,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          padding: EdgeInsets.all(15.0),
          barCount: 2,
          colors: [
            Colors.grey[400],
            Colors.grey[500],
            Colors.grey[600],
          ],
          isAnimation: true,
        ),
      ),
    );
    ;
  }
}
