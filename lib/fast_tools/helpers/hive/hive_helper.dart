import 'package:hive_flutter/hive_flutter.dart';

class HiveBox {
  static Future<Box> customBox(String name) async {
    return Hive.openBox(name);
  }

  static Future<Box> get civics => Hive.openBox(_HiveBoxesNames.civics);
  static Future<Box> get writing => Hive.openBox(_HiveBoxesNames.writing);
  static Future<Box> get reading => Hive.openBox(_HiveBoxesNames.reading);
  static Future<Box> get trackingData =>
      Hive.openBox(_HiveBoxesNames.trackingData);
}

class _HiveBoxesNames {
  static const String civics = 'civics';
  static const String writing = 'writing';
  static const String reading = 'reading';
  static const String trackingData = 'trackingData';
}
