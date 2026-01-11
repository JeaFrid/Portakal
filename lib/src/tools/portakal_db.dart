import 'package:hive_flutter/hive_flutter.dart';

class PortakalDB {
  static const String _boxName = 'portakal_db';

  static Future<void> save(String key, dynamic value) async {
    final box = await Hive.openBox(_boxName);
    await box.put(key, value);
  }

  static Future<dynamic> get(String key, {dynamic defaultValue}) async {
    final box = await Hive.openBox(_boxName);
    return box.get(key, defaultValue: defaultValue);
  }

  static Future<void> remove(String key) async {
    final box = await Hive.openBox(_boxName);
    await box.delete(key);
  }

  static Future<void> clear() async {
    final box = await Hive.openBox(_boxName);
    await box.clear();
  }
}
