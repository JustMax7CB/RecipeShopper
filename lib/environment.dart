sealed class EnvVariables {
  static const String projectId = String.fromEnvironment('PROJECT_ID');
  static const String dbId = String.fromEnvironment('DB_ID');
  static const String recipeCollectionId = String.fromEnvironment('RECIPE_COLLECTION_ID');
  static const String ingredientsCollectionId = String.fromEnvironment('INGREDIENTS_COLLECTION_ID');
  static const String recipeImagesBucketId = String.fromEnvironment("RECIPE_IMAGES_BUCKET_ID");
}
