import 'package:flutter_bugfender/flutter_bugfender.dart';

class EnvVariables {
  static const String projectId = String.fromEnvironment('PROJECT_ID');
  static const String dbId = String.fromEnvironment('DB_ID');
  static const String recipeCollectionId =
      String.fromEnvironment('RECIPE_COLLECTION_ID');
  static const String ingredientsCollectionId =
      String.fromEnvironment('INGREDIENTS_COLLECTION_ID');
  static const String recipeImagesBucketId =
      String.fromEnvironment("RECIPE_IMAGES_BUCKET_ID");

  void checkIds() {
    FlutterBugfender.debug("PROJECT_ID: $projectId");
    FlutterBugfender.debug("DB_ID: $dbId");
    FlutterBugfender.debug("RECIPE_COLLECTION_ID: $recipeCollectionId");
    FlutterBugfender.debug(
        "INGREDIENTS_COLLECTION_ID: $ingredientsCollectionId");
    FlutterBugfender.debug("RECIPE_IMAGES_BUCKET_ID: $recipeImagesBucketId");
  }
}
