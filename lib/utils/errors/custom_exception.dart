class CustomException implements Exception {
  String error;
  CustomException(this.error);
  @override
  String toString() {
    return error;
  }
}
