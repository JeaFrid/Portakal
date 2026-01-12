import 'package:flutter/material.dart';
import 'package:portakal/src/tools/state_management.dart';

class _PortakalThemeColors {
  Color backgroundLight = const Color.fromARGB(255, 240, 240, 240);
  Color defaultColorLight = Colors.orange[800] as Color;
  Color textColorLight = Colors.black;
  Color cardColorLight = const Color.fromARGB(255, 255, 255, 255);
  Color secondCardColorLight = Color.fromARGB(255, 230, 230, 230);

  Color backgroundDark = const Color.fromARGB(255, 12, 12, 12);
  Color defaultColorDark = Colors.orange[800] as Color;
  Color textColorDark = Colors.white;
  Color cardColorDark = const Color.fromARGB(255, 20, 20, 20);
  Color secondCardColorDark = const Color.fromARGB(255, 26, 26, 26);

  void setLight(
    Color setBackground,
    Color setDefaultColor,
    Color setTextColor,
    Color setCardColor,
    Color setSecondCardColor,
  ) {
    backgroundLight = setBackground;
    defaultColorLight = setDefaultColor;
    textColorLight = setTextColor;
    cardColorLight = setCardColor;
    secondCardColorLight = setSecondCardColor;
  }

  void setDark(
    Color setBackground,
    Color setDefaultColor,
    Color setTextColor,
    Color setCardColor,
    Color setSecondCardColor,
  ) {
    backgroundDark = setBackground;
    defaultColorDark = setDefaultColor;
    textColorDark = setTextColor;
    cardColorDark = setCardColor;
    secondCardColorDark = setSecondCardColor;
  }
}

class PortakalThemeData {
  final Color background;
  final Color defaultColor;
  final Color textColor;
  final Color cardColor;
  final Color secondCardColor;
  PortakalThemeData({
    required this.background,
    required this.defaultColor,
    required this.textColor,
    required this.cardColor,
    required this.secondCardColor,
  });
}

class PortakalTheme {
  static final _PortakalThemeColors _c = _PortakalThemeColors();

  static PManager<Color> background = PManager(_c.backgroundDark);
  static PManager<Color> defaultColor = PManager(_c.defaultColorDark);
  static PManager<Color> textColor = PManager(_c.textColorDark);
  static PManager<Color> cardColor = PManager(_c.cardColorDark);
  static PManager<Color> secondCardColor = PManager(_c.secondCardColorDark);

  static void setDarkThemeData({
    Color? setBackgroundColor,
    Color? setTextColor,
    Color? setDefaultColor,
    Color? setCardColor,
    Color? setSecondCardColor,
  }) {
    background.set(setBackgroundColor ?? _c.backgroundDark);
    defaultColor.set(setDefaultColor ?? _c.defaultColorDark);
    textColor.set(setTextColor ?? _c.textColorDark);
    cardColor.set(setCardColor ?? _c.cardColorDark);
    secondCardColor.set(setSecondCardColor ?? _c.secondCardColorDark);

    theme.set(_createThemeData(brightness: Brightness.dark));

    theme.up();
    setUp();
  }

  static void setLightThemeData({
    Color? setBackgroundColor,
    Color? setTextColor,
    Color? setDefaultColor,
    Color? setCardColor,
    Color? setSecondCardColor,
  }) {
    background.set(setBackgroundColor ?? _c.backgroundLight);
    defaultColor.set(setDefaultColor ?? _c.defaultColorLight);
    textColor.set(setTextColor ?? _c.textColorLight);
    cardColor.set(setCardColor ?? _c.cardColorLight);
    secondCardColor.set(setSecondCardColor ?? _c.secondCardColorLight);
    theme.set(_createThemeData(brightness: Brightness.light));

    theme.up();
    setUp();
  }

  static void setUp() {
    background.up();
    defaultColor.up();
    textColor.up();
    cardColor.up();
    secondCardColor.up();
  }

  static ThemeData _createThemeData({required Brightness brightness}) {
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: background(),
      canvasColor: background(),
      cardColor: cardColor(),
      dividerColor: textColor().withOpacity(0.12),
      dialogBackgroundColor: cardColor(),
      indicatorColor: defaultColor(),
      appBarTheme: AppBarTheme(
        backgroundColor: background(),
        foregroundColor: textColor(),
        elevation: 0,
        iconTheme: IconThemeData(color: textColor()),
        actionsIconTheme: IconThemeData(color: textColor()),
        titleTextStyle: TextStyle(
          color: textColor(),
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
      iconTheme: IconThemeData(color: textColor()),
      cardTheme: CardThemeData(
        color: cardColor(),
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.black.withOpacity(0.2),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: defaultColor(),
          foregroundColor: textColor(),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: defaultColor(),
        foregroundColor: textColor(),
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(color: textColor()),
        displayMedium: TextStyle(color: textColor()),
        displaySmall: TextStyle(color: textColor()),
        headlineLarge: TextStyle(color: textColor()),
        headlineMedium: TextStyle(color: textColor()),
        headlineSmall: TextStyle(color: textColor()),
        titleLarge: TextStyle(color: textColor()),
        titleMedium: TextStyle(color: textColor()),
        titleSmall: TextStyle(color: textColor()),
        bodyLarge: TextStyle(color: textColor()),
        bodyMedium: TextStyle(color: textColor()),
        bodySmall: TextStyle(color: textColor()),
        labelLarge: TextStyle(color: textColor()),
        labelMedium: TextStyle(color: textColor()),
        labelSmall: TextStyle(color: textColor()),
      ),
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: defaultColor(),
        onPrimary: textColor(),
        secondary: secondCardColor(),
        onSecondary: textColor(),
        error: Colors.red,
        onError: textColor(),
        surface: cardColor(),
        onSurface: textColor(),
        surfaceContainer: secondCardColor(),
      ),
    );
  }

  static PManager<ThemeData> theme = PManager(
    _createThemeData(brightness: Brightness.dark),
  );

  static ThemeData getThemeData() {
    return theme();
  }

  static bool isDarkMode() {
    return theme().brightness == Brightness.dark;
  }
}

Color get background => PortakalTheme.background();
Color get defaultColor => PortakalTheme.defaultColor();
Color get textColor => PortakalTheme.textColor();
Color get cardColor => PortakalTheme.cardColor();
Color get secondCardColor => PortakalTheme.secondCardColor();
