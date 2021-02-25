import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/sliver_persistent_header.dart';
import 'package:happening/constants/basicConsts.dart';
import 'package:happening/models/currentuser.dart';
import 'package:happening/painter/splashyPainter.dart';
import 'package:happening/widgets/basicwidgets.dart';

class UserPageHeader implements SliverPersistentHeaderDelegate {
  double max;
  double min;
  User user;
  Color c = randomColor();
  UserPageHeader({this.max, this.min, this.user});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    print(shrinkOffset);
    return Container(
      color: c,
      height: max,
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                BackButton(),
                shrinkOffset > 100
                    ? Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(
                                user.image ?? DefaultTexts.defImage),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.name,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Text('${user.status}'),
                              ],
                            ),
                          ),
                        ],
                      )
                    : SizedBox()
              ],
            ),
            shrinkOffset > 100
                ? Expanded(
                    child: Container(),
                  )
                : Expanded(
                    child: CircleAvatar(
                      radius: double.infinity,
                      backgroundImage:
                          NetworkImage(user.image ?? DefaultTexts.defImage),
                    ),
                  ),
            shrinkOffset > 100
                ? SizedBox()
                : Column(
                    children: [
                      Text(
                        user.name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Text('${user.status}'),
                    ],
                  ),
            shrinkOffset >= max - min
                ? SizedBox()
                : Transform.scale(
                    scale: shrinkOffset < 230 ? 1 : 230 / max,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${user.followers.length} followers'),
                              Text(
                                  'joined on ${user.createdAt.toUtc().toString().split(' ')[0]} '),
                            ],
                          ),
                        ),
                        FollowButton(user),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => max;

  @override
  double get minExtent => min;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }

  @override
  // TODO: implement snapConfiguration
  FloatingHeaderSnapConfiguration get snapConfiguration => null;

  @override
  // TODO: implement stretchConfiguration
  OverScrollHeaderStretchConfiguration get stretchConfiguration => null;

  @override
  // TODO: implement showOnScreenConfiguration
  PersistentHeaderShowOnScreenConfiguration get showOnScreenConfiguration =>
      throw UnimplementedError();

  @override
  // TODO: implement vsync
  TickerProvider get vsync => throw UnimplementedError();
}
