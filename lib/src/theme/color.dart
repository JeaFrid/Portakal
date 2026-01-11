import 'package:flutter/material.dart';


class PortakalColor extends Color {
  const PortakalColor(super.value);

  factory PortakalColor.fromHex(String hexCode) {
    String cleanCode = hexCode.toUpperCase().replaceAll("#", "");
    if (cleanCode.length == 6) {
      cleanCode = "FF$cleanCode";
    }

    if (cleanCode.length != 8) {
      return const PortakalColor(0xFF000000);
    }

    return PortakalColor(int.parse(cleanCode, radix: 16));
  }

  factory PortakalColor.fromColor(Color color) {
    return PortakalColor(color.value);
  }

  String toHex({bool includeHash = true, bool includeAlpha = true}) {
    String alpha = value
        .toRadixString(16)
        .toUpperCase()
        .padLeft(8, '0')
        .substring(0, 2);
    String hex = value
        .toRadixString(16)
        .toUpperCase()
        .padLeft(8, '0')
        .substring(2);

    if (!includeAlpha) {
      return includeHash ? "#$hex" : hex;
    }
    return includeHash ? "#$alpha$hex" : "$alpha$hex";
  }

  PortakalColor wOpacity(double value) {
    assert(value >= 0.0 && value <= 1.0);
    return PortakalColor(withOpacity(value).value);
  }

  PortakalColor darken([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return PortakalColor(hslDark.toColor().value);
  }

  PortakalColor lighten([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final hslLight = hsl.withLightness(
      (hsl.lightness + amount).clamp(0.0, 1.0),
    );
    return PortakalColor(hslLight.toColor().value);
  }

  PortakalColor mix(Color other, [double amount = 0.5]) {
    return PortakalColor(Color.lerp(this, other, amount)!.value);
  }

  PortakalColor get complementary {
    final hsl = HSLColor.fromColor(this);
    double newHue = (hsl.hue + 180.0) % 360.0;
    return PortakalColor(hsl.withHue(newHue).toColor().value);
  }

  Color get contrastText {
    return computeLuminance() > 0.5 ? Colors.black : Colors.white;
  }

  MaterialColor toMaterialColor() {
    return MaterialColor(value, <int, Color>{
      50: lighten(0.5),
      100: lighten(0.4),
      200: lighten(0.3),
      300: lighten(0.2),
      400: lighten(0.1),
      500: this,
      600: darken(0.1),
      700: darken(0.2),
      800: darken(0.3),
      900: darken(0.4),
    });
  }
}
