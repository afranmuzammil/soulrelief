import 'package:flutter/material.dart';

class RadiantGradientMask extends StatelessWidget {
  RadiantGradientMask({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => RadialGradient(
        center: Alignment.bottomLeft,
        radius: 0.8,
        colors: [ Color(0xff193B92),Color(0xff921985)],
        tileMode: TileMode.mirror,
      ).createShader(bounds),
      child: child,
    );
  }
}