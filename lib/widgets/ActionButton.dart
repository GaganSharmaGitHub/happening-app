import 'package:happening/constants/basicConsts.dart';
import 'package:flutter/material.dart';

class HappButton extends StatelessWidget {
  final Function onPressed;
  final double width;
  final Widget child;
  final double radius;
  HappButton(
      {Key key, @required this.child, this.onPressed, this.radius, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      child: RaisedButton(
        child: child,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(radius ?? 30),
          ),
        ),
        onPressed: onPressed,
        textColor: AppColors.lightColor,
      ),
    );
  }
}
