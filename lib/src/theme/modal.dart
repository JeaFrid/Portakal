import 'package:flutter/material.dart';
import 'package:portakal/src/theme/theme.dart';

class PortakalModal {
  static Future<T?> showBottom<T>(
    BuildContext context, {
    required Widget child,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      backgroundColor: PortakalTheme.cardColor(),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) =>
          Padding(padding: const EdgeInsets.all(16.0), child: child),
    );
  }

  static Future<T?> showPopup<T>(
    BuildContext context, {
    required String title,
    required Widget content,
    VoidCallback? onConfirm,
    String confirmText = "Ok",
  }) {
    return showDialog<T>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: PortakalTheme.cardColor(),
        title: Text(title, style: TextStyle(color: PortakalTheme.textColor())),
        content: content,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Cancel",
              style: TextStyle(
                color: PortakalTheme.textColor().withOpacity(0.5),
              ),
            ),
          ),
          if (onConfirm != null)
            TextButton(
              onPressed: () {
                onConfirm();
                Navigator.pop(context);
              },
              child: Text(
                confirmText,
                style: TextStyle(color: PortakalTheme.defaultColor()),
              ),
            ),
        ],
      ),
    );
  }
}
