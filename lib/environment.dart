sealed class EnvVariables {
  static const projectId = String.fromEnvironment('PROJECT_ID');
  static const dbId = String.fromEnvironment('DB_ID');
  static const recipeCollectionId = String.fromEnvironment('RECIPE_COLLECTION_ID');
}