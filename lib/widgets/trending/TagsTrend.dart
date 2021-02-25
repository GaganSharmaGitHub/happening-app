import 'package:flutter/material.dart';
import 'package:happening/constants/basicConsts.dart';
import 'package:happening/models/tag.dart';
import 'package:happening/painter/splashyPainter.dart';
import 'package:happening/widgets/trending/splashyTag.dart';

class TagsTrend extends StatelessWidget {
  TagsTrend({
    Key key,
    @required this.tags,
  }) : super(key: key);

  final List<TagTrending> tags;
  final ScrollController _controller =
      ScrollController(initialScrollOffset: 100);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Trending tags'),
        Expanded(
          child: ListView.builder(
            controller: _controller,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => SplashedTag(
              tag: tags[index],
              color: colors[index % colors.length].color.withOpacity(0.8),
            ),
            itemCount: tags.length,
          ),
        ),
      ],
    );
  }
}
