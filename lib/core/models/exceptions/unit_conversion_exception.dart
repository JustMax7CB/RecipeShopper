// Custom exception for unit conversion errors
class UnitConversionException implements Exception {
  final String message;
  UnitConversionException(this.message);

  @override
  String toString() => 'UnitConversionException: $message';
}
