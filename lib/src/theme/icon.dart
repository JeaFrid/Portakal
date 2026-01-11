import 'package:flutter/material.dart';
import 'package:portakal/src/theme/icons.dart';
import 'package:portakal/src/theme/theme.dart';

class PortakalIcon extends StatelessWidget {
  final PortakalIcons path;
  final double? size;
  final Color? color;
  const PortakalIcon(this.path, {super.key, this.size, this.color});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      path.path,
      color: color ?? PortakalTheme.textColor(),
      width: size ?? 24,
      height: size ?? 24,
    );
  }
}
