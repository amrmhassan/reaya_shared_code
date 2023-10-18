import 'package:hive_flutter/hive_flutter.dart';

class HiveInitiator {
  Future<void> setup() async {
    await Hive.initFlutter();
    await _registerAdapters();
  }

  Future<void> _registerAdapters() async {
    // Hive.registerAdapter(CustomDurationAdapter()); //=>0
  }
}
