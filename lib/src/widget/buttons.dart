
import 'package:flutter/material.dart';
import 'package:portakal/src/theme/theme.dart';
import 'package:portakal/src/widget/pressable.dart';
import 'package:portakal/src/widget/text.dart';

enum PortakalButtonType {
  normal(0),
  border(1),
  ghost(2),
  raindrop(3),
  radiusTop(4),
  radiusBottom(5),
  radiusRight(6),
  duotone(7),
  radiusLeft(8);

  final int value;
  const PortakalButtonType(this.value);
}

class PortakalButton extends StatelessWidget {
  final PortakalButtonType type;
  final String text;
  final Function()? onTap;
  final Function()? onLongTap;
  final int? dismissCount;
  final Widget? child;
  final Color? backgroundColor;
  final EdgeInsetsGeometry padding;
  final Duration cooldown;
  const PortakalButton({
    super.key,
    required this.type,
    required this.text,
    this.onTap,
    this.onLongTap,
    this.dismissCount,
    this.cooldown = const Duration(seconds: 1),
    this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    if (PortakalButtonType.normal == type) {
      return PortakalPressable(
        cooldown: cooldown,
        dismissCount: dismissCount,
        onTap: onTap ?? () {},
        onLongPress: onLongTap ?? () {},
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: backgroundColor ?? PortakalTheme.defaultColor(),
          ),
          child: Center(child: child ?? bold(context, text)),
        ),
      );
    } else if (PortakalButtonType.border == type) {
      return PortakalPressable(
        cooldown: cooldown,
        dismissCount: dismissCount,
        onTap: onTap ?? () {},
        onLongPress: onLongTap ?? () {},
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            border: Border.all(
              color: backgroundColor ?? PortakalTheme.defaultColor(),
              width: 1.4,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(child: child ?? bold(context, text)),
        ),
      );
    } else if (PortakalButtonType.duotone == type) {
      return PortakalPressable(
        cooldown: cooldown,
        dismissCount: dismissCount,
        onTap: onTap ?? () {},
        onLongPress: onLongTap ?? () {},
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            border: Border.all(
              color: backgroundColor ?? PortakalTheme.defaultColor(),
              width: 1.4,
            ),
            borderRadius: BorderRadius.circular(10),
            color: (backgroundColor ?? PortakalTheme.defaultColor())
                .withOpacity(0.1),
          ),
          child: Center(child: child ?? bold(context, text)),
        ),
      );
    } else if (PortakalButtonType.ghost == type) {
      return PortakalPressable(
        cooldown: cooldown,
        dismissCount: dismissCount,
        onTap: onTap ?? () {},
        onLongPress: onLongTap ?? () {},
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.transparent,
          ),
          child: Center(child: child ?? bold(context, text)),
        ),
      );
    } else if (PortakalButtonType.raindrop == type) {
      return PortakalPressable(
        cooldown: cooldown,
        dismissCount: dismissCount,
        onTap: onTap ?? () {},
        onLongPress: onLongTap ?? () {},
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            color: backgroundColor ?? PortakalTheme.defaultColor(),
          ),
          child: Center(child: child ?? bold(context, text)),
        ),
      );
    } else if (PortakalButtonType.radiusBottom == type) {
      return PortakalPressable(
        cooldown: cooldown,
        dismissCount: dismissCount,
        onTap: onTap ?? () {},
        onLongPress: onLongTap ?? () {},
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            color: backgroundColor ?? PortakalTheme.defaultColor(),
          ),
          child: Center(child: child ?? bold(context, text)),
        ),
      );
    } else if (PortakalButtonType.radiusTop == type) {
      return PortakalPressable(
        cooldown: cooldown,
        dismissCount: dismissCount,
        onTap: onTap ?? () {},
        onLongPress: onLongTap ?? () {},
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            color: backgroundColor ?? PortakalTheme.defaultColor(),
          ),
          child: Center(child: child ?? bold(context, text)),
        ),
      );
    } else if (PortakalButtonType.radiusRight == type) {
      return PortakalPressable(
        cooldown: cooldown,
        dismissCount: dismissCount,
        onTap: onTap ?? () {},
        onLongPress: onLongTap ?? () {},
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
            color: backgroundColor ?? PortakalTheme.defaultColor(),
          ),
          child: Center(child: child ?? bold(context, text)),
        ),
      );
    } else if (PortakalButtonType.radiusLeft == type) {
      return PortakalPressable(
        cooldown: cooldown,
        dismissCount: dismissCount,
        onTap: onTap ?? () {},
        onLongPress: onLongTap ?? () {},
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            color: backgroundColor ?? PortakalTheme.defaultColor(),
          ),
          child: Center(child: child ?? bold(context, text)),
        ),
      );
    }

    return PortakalPressable(
      cooldown: cooldown,
      dismissCount: dismissCount,
      onTap: onTap ?? () {},
      onLongPress: onLongTap ?? () {},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: PortakalTheme.defaultColor(),
        ),
        child: Center(child: bold(context, text)),
      ),
    );
  }
}
