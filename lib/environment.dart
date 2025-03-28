import 'package:flutter_bugfender/flutter_bugfender.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvVariables {
  static final String projectId =
      dotenv.get('PROJECT_ID', fallback: "default_project_id");

  static final String dbId = dotenv.get('DB_ID', fallback: "default_db_id");
  static final String recipeCollectionId =
      dotenv.get('RECIPE_COLLECTION_ID', fallback: "default_recipe_coll_id");
  static final String ingredientsCollectionId = dotenv
      .get('INGREDIENTS_COLLECTION_ID', fallback: "default_ingredient_coll_id");
  static final String recipeImagesBucketId = dotenv.get(
      "RECIPE_IMAGES_BUCKET_ID",
      fallback: "default_recipe_image_bucket_id");

  void checkIds() {
    FlutterBugfender.debug("PROJECT_ID: $projectId");
    FlutterBugfender.debug("DB_ID: $dbId");
    FlutterBugfender.debug("RECIPE_COLLECTION_ID: $recipeCollectionId");
    FlutterBugfender.debug(
        "INGREDIENTS_COLLECTION_ID: $ingredientsCollectionId");
    FlutterBugfender.debug("RECIPE_IMAGES_BUCKET_ID: $recipeImagesBucketId");
  }
}
