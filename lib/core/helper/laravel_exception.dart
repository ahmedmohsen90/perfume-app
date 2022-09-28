

class LaravelException implements Exception {
  LaravelException(this.exception);
  final String exception;
  @override
  String toString() {
    return exception.toString();
  }
}
