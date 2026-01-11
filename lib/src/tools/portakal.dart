import 'package:flutter/rendering.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:portakal/src/widget/text.dart';

class Portakal {
  static Future<void> init({
    TextStyle Function(TextStyle)? setFontBuilder,
  }) async {
    if (setFontBuilder != null) {
      PortakalFontConfig.setFont(setFontBuilder);
    }

    await Hive.initFlutter();
    Hive.openBox("portakal_db");
    await Hive.openBox("imageCache");
  }
}
