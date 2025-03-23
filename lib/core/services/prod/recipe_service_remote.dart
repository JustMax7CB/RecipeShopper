import 'package:appwrite/appwrite.dart';
import 'package:injectable/injectable.dart';
import 'package:recipeshopper/core/di/locator.dart';
import 'package:recipeshopper/core/models/recipe.dart';
import 'package:recipeshopper/core/services/recipe_service.dart';
import 'package:recipeshopper/environment.dart';
import 'package:recipeshopper/extensions.dart';

@Singleton()
class RemoteRecipeService implements RecipeService {
  final Databases appWriteDB;

  RemoteRecipeService() : appWriteDB = Databases(locate<Account>().client);

  @override
  Future<void> saveRecipe(Recipe recipe) async {
    final remoteImageId = recipe.isPlaceholder
        ? recipe.imagePath
        : await _uploadRecipeImage(recipe.imagePath!);

    final newRecipe = recipe.copyWith(imagePath: remoteImageId);

    final response = await appWriteDB.createDocument(
        databaseId: EnvVariables.dbId,
        collectionId: EnvVariables.recipeCollectionId,
        documentId: recipe.id,
        data: newRecipe.toJson());

    response.data.printPretty();
  }

  Future<String> _uploadRecipeImage(String path) async {
    final storage = Storage(locate<Client>());

    final response = await storage.createFile(
      bucketId: EnvVariables.recipeImagesBucketId,
      fileId: ID.unique(),
      file: InputFile.fromPath(path: path, filename: path.split("/").last),
    );

    return response.$id;
  }

  @override
  Future<void> deleteRecipe(String id) async {
    await appWriteDB.deleteDocument(
        databaseId: EnvVariables.dbId,
        collectionId: EnvVariables.recipeCollectionId,
        documentId: id);
  }

  @override
  Future<List<Recipe>> getAllRecipes() async {
    final response = await appWriteDB.listDocuments(
        databaseId: EnvVariables.dbId,
        collectionId: EnvVariables.recipeCollectionId);

    return response.documents.map((doc) => Recipe.fromJson(doc.data)).toList();
  }

  @override
  Future<Recipe> getRecipeById(String id) async {
    final response = await appWriteDB.getDocument(
        databaseId: EnvVariables.dbId,
        collectionId: EnvVariables.recipeCollectionId,
        documentId: id);

    return Recipe.fromJson(response.data);
  }

  @override
  Future<void> updateRecipe(Recipe updatedRecipe) async {
    final response = await appWriteDB.updateDocument(
        databaseId: EnvVariables.dbId,
        collectionId: EnvVariables.recipeCollectionId,
        documentId: updatedRecipe.id,
        data: updatedRecipe.toJson());

    response.data.printPretty();
  }
}
