import 'package:flutter/material.dart';

class LoadingDisabler extends StatelessWidget {
  final bool isLoading;
  final Widget loader;
  final double opacity;
  final Widget child;
  LoadingDisabler(
      {@required this.isLoading,
      @required this.child,
      @required this.loader,
      this.opacity});
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isLoading ? opacity ?? 0.5 : 1,
      child: AbsorbPointer(
        absorbing: isLoading,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            child,
            isLoading
                ? loader
                : SizedBox(
                    height: 0,
                    width: 0,
                  )
          ],
        ),
      ),
    );
  }
}
