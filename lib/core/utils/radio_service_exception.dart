class RadioServiceException implements Exception {
  final String message;
  RadioServiceException(this.message);

  @override
  String toString() => 'RadioServiceException: $message';
}