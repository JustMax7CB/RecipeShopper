import 'package:flutter_dotenv/flutter_dotenv.dart';

sealed class EnvVariables {
  static String projectId = dotenv.env['PROJECT_ID'] ?? "";
  static String dbId = dotenv.env['DB_ID'] ?? "";
  static String recipeCollectionId = dotenv.env['RECIPE_COLLECTION_ID'] ?? "";
  static String recipeImagesBucketId = dotenv.env["RECIPE_IMAGES_BUCKET_ID"] ?? "";
}
