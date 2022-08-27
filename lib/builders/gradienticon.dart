import 'package:flutter/material.dart';

class RadiantGradientMask extends StatelessWidget {
  RadiantGradientMask({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => RadialGradient(
        center: Alignment.center,
        radius: 0.5,
        colors: [ Color(0xffD1549E),Color(0xff3B4C77)],
        tileMode: TileMode.mirror,
      ).createShader(bounds),
      child: child,
    );
  }
}