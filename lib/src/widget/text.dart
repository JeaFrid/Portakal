import 'package:flutter/material.dart';
import 'package:portakal/src/theme/theme.dart';

Widget h1(BuildContext context, String text, {Color? color}) {
  return Text(
    text,
    style: PortakalFontConfig.apply(
      TextStyle(
        color: color ?? PortakalTheme.textColor(),
        fontWeight: FontWeight.bold,
        fontSize: 28,
      ),
    ),
  );
}

Widget h2(
  BuildContext context,
  String text, {
  TextAlign? textAlign,
  List<Shadow>? shadows,
}) {
  return Text(
    text,
    textAlign: textAlign,
    style: PortakalFontConfig.apply(
      TextStyle(
        color: PortakalTheme.textColor(),
        fontWeight: FontWeight.bold,
        fontSize: 25,
        shadows: shadows,
      ),
    ),
  );
}

Widget h3(
  BuildContext context,
  String text, {
  int? maxLines,
  double? height,
  TextOverflow? overflow,
  double? size,
  Color? color,
  TextAlign? textAlign,
  FontWeight? fontWeight,
}) {
  return Text(
    text,
    maxLines: maxLines,
    overflow: overflow,
    textAlign: textAlign,
    style: PortakalFontConfig.apply(
      TextStyle(
        height: height ?? 0.98,
        color: color ?? PortakalTheme.textColor(),
        fontWeight: fontWeight ?? FontWeight.bold,
        fontSize: size ?? 20,
      ),
    ),
  );
}

Widget h4(BuildContext context, String text) {
  return Text(
    text,
    style: PortakalFontConfig.apply(
      TextStyle(
        color: PortakalTheme.textColor(),
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    ),
  );
}

Widget h5(
  BuildContext context,
  String text, {
  int? maxLines,
  TextOverflow? overflow,
  double? size,
  Color? color,
  TextAlign? textAlign,
  FontWeight? fontWeight,
}) {
  return Text(
    text,
    maxLines: maxLines,
    overflow: overflow,
    textAlign: textAlign,
    style: PortakalFontConfig.apply(
      TextStyle(
        height: 0.98,
        color: color ?? PortakalTheme.textColor(),
        fontWeight: fontWeight ?? FontWeight.bold,
        fontSize: size ?? 16,
      ),
    ),
  );
}

Widget p(
  BuildContext context,
  String text, {
  int? maxLines,
  Color? color,
  TextOverflow? overflow,
  TextAlign? textAlign,
  double? size,
  TextDecoration? decoration,
}) {
  return Text(
    text,
    maxLines: maxLines,
    overflow: overflow,
    textAlign: textAlign,
    style: PortakalFontConfig.apply(
      TextStyle(
        color: color ?? PortakalTheme.textColor(),
        fontSize: size ?? 14,
        decoration: decoration,
      ),
    ),
  );
}

Widget subP(
  BuildContext context,
  String text, {
  int? maxLines,
  Color? color,
  TextOverflow? overflow,
  double? size,
  TextAlign? textAlign,
  FontWeight? fontWeight,
}) {
  return Text(
    text,
    maxLines: maxLines,
    overflow: overflow,
    textAlign: textAlign,
    style: PortakalFontConfig.apply(
      TextStyle(
        color: color ?? PortakalTheme.textColor(),
        fontSize: size ?? 12,
        fontWeight: fontWeight,
      ),
    ),
  );
}

Widget subPName(
  BuildContext context,
  String text, {
  int? maxLines,
  Color? color,
  TextOverflow? overflow,
  double? size,
  TextAlign? textAlign,
  FontWeight? fontWeight,
}) {
  return Text(
    text.length > 8 ? text.substring(0, 8) : text,
    maxLines: maxLines,
    overflow: overflow,
    textAlign: textAlign,
    style: PortakalFontConfig.apply(
      TextStyle(
        color: color ?? PortakalTheme.textColor(),
        fontSize: size ?? 12,
        fontWeight: fontWeight,
      ),
    ),
  );
}

Widget bold(
  BuildContext context,
  String text, {
  int? maxLines,
  TextOverflow? overflow,
  TextAlign? textAlign,
  double? size,
  Color? color,
}) {
  return Text(
    text,
    maxLines: maxLines,
    overflow: overflow,
    textAlign: textAlign,
    style: PortakalFontConfig.apply(
      TextStyle(
        color: color ?? PortakalTheme.textColor(),
        fontWeight: FontWeight.bold,
        fontSize: size ?? 14,
      ),
    ),
  );
}

Widget italic(BuildContext context, String text) {
  return Text(
    text,
    style: PortakalFontConfig.apply(
      TextStyle(
        color: PortakalTheme.textColor(),
        fontStyle: FontStyle.italic,
        fontSize: 14,
      ),
    ),
  );
}

class PortakalFontConfig {
  static TextStyle Function(TextStyle style)? _fontBuilder;

  static void setFont(TextStyle Function(TextStyle style) builder) {
    _fontBuilder = builder;
  }

  static TextStyle apply(TextStyle style) {
    if (_fontBuilder != null) {
      return _fontBuilder!(style);
    }
    return style;
  }
}
