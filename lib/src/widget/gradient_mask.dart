import 'package:flutter/material.dart';

class PortakalGradientMask extends StatelessWidget {
  final Widget child;
  final List<Color> colors;
  const PortakalGradientMask({super.key, required this.child, required this.colors});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: colors,
      ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
      blendMode: BlendMode.srcIn,
      child: child,
    );
  }
}
