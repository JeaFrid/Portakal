import 'package:flutter/material.dart';

extension PortakalContextExtension on BuildContext {
  double get width => MediaQuery.sizeOf(this).width;
  double get height => MediaQuery.sizeOf(this).height;

  double get topPadding => MediaQuery.paddingOf(this).top;
  double get bottomPadding => MediaQuery.paddingOf(this).bottom;

  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;

  bool get isMobile => width < 600;
  bool get isTablet => width >= 600 && width < 1024;
  bool get isDesktop => width >= 1024;

  void hideKeyboard() {
    final currentFocus = FocusScope.of(this);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  bool get isKeyBoardOpen => MediaQuery.viewInsetsOf(this).bottom > 0;

  Future<T?> push<T>(Widget page) {
    return Navigator.push<T>(
      this,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  void pop<T>([T? result]) {
    Navigator.pop<T>(this, result);
  }

  void showSnackBar(String message, {Color? backgroundColor}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor ?? colorScheme.primary,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

extension PortakalStringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String get removeWhitespace => replaceAll(RegExp(r'\s+'), '');

  bool get isValidEmail {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);
  }

  Color toColor() {
    var hexColor = replaceAll("#", "");
    if (hexColor.length == 6) hexColor = "FF$hexColor";
    return Color(int.parse(hexColor, radix: 16));
  }
}

extension PortakalNumExtension on num {
  SizedBox get h => SizedBox(height: toDouble());
  SizedBox get w => SizedBox(width: toDouble());

  EdgeInsets get pAll => EdgeInsets.all(toDouble());
  EdgeInsets get pSymmetric =>
      EdgeInsets.symmetric(vertical: toDouble(), horizontal: toDouble());
  EdgeInsets get pHorizontal => EdgeInsets.symmetric(horizontal: toDouble());
  EdgeInsets get pVertical => EdgeInsets.symmetric(vertical: toDouble());
}

extension PortakalWidgetExtension on Widget {
  Widget padding(EdgeInsets padding) => Padding(padding: padding, child: this);

  Widget center() => Center(child: this);

  Widget expanded({int flex = 1}) => Expanded(flex: flex, child: this);

  Widget opacity(double opacity) => Opacity(opacity: opacity, child: this);
}
