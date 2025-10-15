// Custom exception for ingredient combination errors
class IngredientCombinationException implements Exception {
  final String message;
  IngredientCombinationException(this.message);

  @override
  String toString() => 'IngredientCombinationException: $message';
}