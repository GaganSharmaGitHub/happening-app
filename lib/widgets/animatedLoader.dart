import 'package:flutter/material.dart';

class AnimatedHappLoader extends StatefulWidget {
  AnimatedHappLoader({Key key}) : super(key: key);

  @override
  _AnimatedHappLoaderState createState() => _AnimatedHappLoaderState();
}

class _AnimatedHappLoaderState extends State<AnimatedHappLoader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CircularProgressIndicator(),
    );
  }
}
