import 'package:flutter/rendering.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:portakal/portakal.dart';

class Portakal {
  static Future<void> init({
    PortakalThemeData? setLightTheme,
    PortakalThemeData? setDarkTheme,
    TextStyle Function(TextStyle)? setFontBuilder,
  }) async {
    if (setLightTheme != null) {
      PortakalTheme.setLightThemeData(
        setBackgroundColor: setLightTheme.background,
        setDefaultColor: setLightTheme.defaultColor,
        setTextColor: setLightTheme.textColor,
        setCardColor: setLightTheme.cardColor,
        setSecondCardColor: setLightTheme.secondCardColor,
      );
    }
    if (setDarkTheme != null) {
      PortakalTheme.setDarkThemeData(
        setBackgroundColor: setDarkTheme.background,
        setDefaultColor: setDarkTheme.defaultColor,
        setTextColor: setDarkTheme.textColor,
        setCardColor: setDarkTheme.cardColor,
        setSecondCardColor: setDarkTheme.secondCardColor,
      );
    }
    if (setFontBuilder != null) {
      PortakalFontConfig.setFont(setFontBuilder);
    }

    await Hive.initFlutter();
    Hive.openBox("portakal_db");
    await Hive.openBox("imageCache");
  }
}
