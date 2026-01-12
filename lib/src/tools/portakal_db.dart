import 'package:hive_flutter/hive_flutter.dart';

class PortakalDB {
  static const String _boxName = 'portakal_db';
  static Box? _box;

  static Future<Box> get _getBox async {
    if (_box != null && _box!.isOpen) return _box!;
    _box = await Hive.openBox(_boxName);
    return _box!;
  }

  static Future<void> save<T>(String key, T value) async {
    final box = await _getBox;
    await box.put(key, value);
  }

  static Future<void> saveAll(Map<String, dynamic> entries) async {
    final box = await _getBox;
    await box.putAll(entries);
  }

  static Future<T?> get<T>(String key, {T? defaultValue}) async {
    final box = await _getBox;
    return box.get(key, defaultValue: defaultValue) as T?;
  }

  static Future<List<T>> getAll<T>() async {
    final box = await _getBox;
    return box.values.cast<T>().toList();
  }

  static Future<bool> has(String key) async {
    final box = await _getBox;
    return box.containsKey(key);
  }

  static Future<void> remove(String key) async {
    final box = await _getBox;
    await box.delete(key);
  }

  static Future<void> removeAll(List<String> keys) async {
    final box = await _getBox;
    await box.deleteAll(keys);
  }

  static Future<void> clear() async {
    final box = await _getBox;
    await box.clear();
  }

  static Future<void> close() async {
    if (_box != null && _box!.isOpen) {
      await _box!.close();
    }
  }

  static Future<int> get length async {
    final box = await _getBox;
    return box.length;
  }

  static Stream<BoxEvent> watch(String key) async* {
    final box = await _getBox;
    yield* box.watch(key: key);
  }
}