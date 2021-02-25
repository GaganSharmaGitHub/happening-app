import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui';

Color randomColor() => colors[Random().nextInt(colors.length)].color;

class SplashyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    renderDrawing(canvas, size);
  }

  void renderDrawing(Canvas canvas, Size size) {
    int iter = 4;

    renderStructure(canvas, size, iter, iter);
  }

  // Recursive function which draws iterations from iter to 0
  void renderStructure(Canvas canvas, Size size, int iter, int initIter) {
    if (iter == 0) {
      return;
    }

    // This was originally meant to capture distance, now while it does have some correlation with distance, don't take that for granted
    // I simply couldn't think of another variable name, my apologies
    double distance = 0.0;

    // Choose a random color for this iteration

    // We draw a LOT of points
    for (double i = 0; i < 100; i = i + 1) {
      Color c = colors[Random().nextInt(colors.length)].color;

      canvas.drawCircle(
        // This is where the magic happens
        Offset(
          (size.width) +
              // Change these functions for various things to happen
              // Change "atan(distance) * sin(distance) * cos(distance)" to "cos(distance) * sin(distance)" or any combination of trigonometric functions
              (distance * cos(distance) * sin(distance)),
          (size.height) +
              // Same changes for these as the top
              // Note that if the top functions and these are the same, you'll get a 45 degree line of points
              (distance * cos(distance) * sin(distance) * tan(distance)),
        ),

        // Change this for changing radius in different iterations
        2,

        // Well... color
        Paint()..color = c.withOpacity(0.5),
      );

      // Change the "0.1" for varying point distances
      distance = distance + (0.2 + (0.1 * initIter - iter));
    }

    // Recursively call the next iteration
    renderStructure(canvas, size, iter - 1, initIter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

// This could have been a list of colors, I just picked the list off another project of mine
var colors = [
  //ColorInfo("black", Colors.black, Colors.black.toString()),
  ColorInfo("red", Colors.red, Colors.red[500].toString()),
  ColorInfo("green", Colors.green, Colors.green[500].toString()),
  ColorInfo("blue", Colors.blue, Colors.blue[500].toString()),
  ColorInfo("yellow", Colors.yellow, Colors.yellow[500].toString()),
  ColorInfo("purple", Colors.purple, Colors.purple[500].toString()),
  ColorInfo("amber", Colors.amber, Colors.amber[500].toString()),
  ColorInfo("cyan", Colors.cyan, Colors.cyan[500].toString()),
  ColorInfo("grey", Colors.grey, Colors.grey[500].toString()),
  ColorInfo("teal", Colors.teal, Colors.teal[500].toString()),
  ColorInfo("pink", Colors.pink, Colors.pink[500].toString()),
  ColorInfo("orange", Colors.orange, Colors.orange[500].toString()),
  //ColorInfo("white", Colors.white, Colors.white.toString()),
  //ColorInfo("transparent", Colors.transparent, Colors.transparent.toString()),
];

class ColorInfo {
  String name;
  MaterialColor color;
  String hex;

  ColorInfo(this.name, this.color, this.hex);
}
