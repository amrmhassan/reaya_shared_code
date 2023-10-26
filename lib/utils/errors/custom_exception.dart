import 'package:reaya_shared_code/init/runt_time_variables.dart';

class CustomException implements Exception {
  String error;
  CustomException(this.error) {
    logger.e(error);
  }
  @override
  String toString() {
    return error;
  }
}
