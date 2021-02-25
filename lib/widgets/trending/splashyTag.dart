import 'package:flutter/material.dart';
import 'package:happening/constants/basicConsts.dart';
import 'package:happening/models/tag.dart';
import 'package:happening/painter/splashyPainter.dart';

class SplashedTag extends StatelessWidget {
  const SplashedTag({
    Key key,
    this.color,
    @required this.tag,
  }) : super(key: key);

  final TagTrending tag;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        child: Container(
          color: color,
          child: CustomPaint(
            painter: SplashyPainter(),
            child: InkWell(
              onTap: () => Navigator.of(context)
                  .pushNamed(Routes.TagPost, arguments: '${tag.tag}'),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          tag.tag.toString(),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          '${tag.count} posts',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
