import 'package:flutter/material.dart';
import 'package:portakal/src/tools/state_management.dart';

class PortakalTheme {
  static PManager<Color> background = PManager(
    const Color.fromARGB(255, 12, 12, 12),
  );
  static PManager<Color> defaultColor = PManager(Colors.orange[800] as Color);
  static PManager<Color> textColor = PManager(Colors.white);
  static PManager<Color> cardColor = PManager(
    const Color.fromARGB(255, 20, 20, 20),
  );
  static PManager<Color> secondCardColor = PManager(
    const Color.fromARGB(255, 26, 26, 26),
  );

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

  static void setDarkThemeData() {
    background.set(const Color.fromARGB(255, 12, 12, 12));
    defaultColor.set(Colors.orange[800] as Color);
    textColor.set(Colors.white);
    cardColor.set(const Color.fromARGB(255, 20, 20, 20));
    secondCardColor.set(const Color.fromARGB(255, 26, 26, 26));

    theme.set(_createThemeData(brightness: Brightness.dark));

    theme.up();
    setUp();
  }

  static void setLightThemeData() {
    background.set(const Color.fromARGB(255, 240, 240, 240));
    defaultColor.set(Colors.orange[800] as Color);
    textColor.set(Colors.black);
    cardColor.set(const Color.fromARGB(255, 255, 255, 255));
    secondCardColor.set(const Color.fromARGB(255, 230, 230, 230));

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
}
