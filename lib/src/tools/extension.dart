import 'package:flutter/material.dart';

extension PortakalContextExtension on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
  
  void hideKeyboard() {
    FocusScope.of(this).unfocus();
  }

  bool get isKeyBoardOpen => MediaQuery.of(this).viewInsets.bottom > 0;
}

extension PortakalStringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String get removeWhitespace => replaceAll(' ', '');
}

extension PortakalNumExtension on num {
  SizedBox get h => SizedBox(height: toDouble());
  SizedBox get w => SizedBox(width: toDouble());
}