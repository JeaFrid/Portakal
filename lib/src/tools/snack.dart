import 'dart:async';

import 'package:delightful_toast/delight_toast.dart';
import 'package:flutter/material.dart';
import 'package:portakal/src/theme/theme.dart';

BuildContext? showSnackSpecial(
  BuildContext context,
  IconData icon,
  String text, {
  String? actionLabel,
  Future<void> Function()? onAction,
}) {
  if (!context.mounted) return null;

  final overlayContext = Navigator.of(
    context,
    rootNavigator: true,
  ).overlay?.context;
  if (overlayContext == null) return null;

  final hasAction = actionLabel != null && onAction != null;
  final title = Text(
    text,
    style: TextStyle(color: PortakalTheme.textColor(), fontSize: 13),
  );
  WidgetsBinding.instance.scheduleFrame();
  DelightToastBar(
    autoDismiss: !hasAction,
    builder: (ctx) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            width: 300,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: PortakalTheme.cardColor(),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: PortakalTheme.secondCardColor(),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: PortakalTheme.defaultColor().withOpacity(0.2),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 20, color: PortakalTheme.defaultColor()),
                const SizedBox(width: 10),
                Expanded(child: title),
                if (hasAction) ...[
                  const SizedBox(width: 10),
                  TextButton(
                    onPressed: () async {
                      DelightToastBar.removeAll();
                      await onAction.call();
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: PortakalTheme.defaultColor(),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      minimumSize: const Size(0, 34),
                    ),
                    child: Text(
                      actionLabel,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: PortakalTheme.defaultColor(),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      );
    },
  ).show(context);
  return context;
}
