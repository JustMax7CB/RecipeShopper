import 'dart:io' as io;
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as appwrite;
import 'package:flutter/material.dart';
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
  Future<Recipe> saveRecipe(Recipe recipe) async {
    var finalRecipe = recipe;
    if (recipe.localImagePath != null) {
      finalRecipe = recipe.copyWith(
          imagePath: recipe.localImagePath,
          remoteFileId: await _uploadRecipeImage(recipe.localImagePath!));
    }

    final response = await appWriteDB.createDocument(
        databaseId: EnvVariables.dbId,
        collectionId: EnvVariables.recipeCollectionId,
        documentId: recipe.id,
        data: finalRecipe.toJson());

    response.data.printPretty();

    return finalRecipe;
  }

  @override
  Future<List<Recipe>> saveRecipeBulk(List<Recipe> recipes) async {
    final List<Recipe> savedRecipes = [];

    for (final recipe in recipes) {
      var finalRecipe = recipe;

      if (recipe.localImagePath != null) {
        final remoteId = await _uploadRecipeImage(recipe.localImagePath!);
        finalRecipe = recipe.copyWith(
          imagePath: recipe.localImagePath,
          remoteFileId: remoteId,
        );
      }

      final response = await appWriteDB.createDocument(
        databaseId: EnvVariables.dbId,
        collectionId: EnvVariables.recipeCollectionId,
        documentId: finalRecipe.id,
        data: finalRecipe.toJson(),
      );

      response.data.printPretty();
      savedRecipes.add(finalRecipe);
    }

    return savedRecipes;
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

  Future<void> _deleteRecipeImage(String fileId) async {
    final storage = Storage(locate<Client>());

    await storage.deleteFile(
        bucketId: EnvVariables.recipeImagesBucketId, fileId: fileId);
  }

  @override
  Future<void> deleteRecipe(String id, {String? imageFileId}) async {
    await appWriteDB.deleteDocument(
        databaseId: EnvVariables.dbId,
        collectionId: EnvVariables.recipeCollectionId,
        documentId: id);
    if (imageFileId != null) await _deleteRecipeImage(imageFileId);
  }

  @override
  Future<List<Recipe>> getAllRecipes() async {
    debugPrint("==== Fetching remote recipes");
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

  Future<io.File> getRecipeImage(String fileId) async {
    final storage = Storage(locate<Client>());

    final response = await storage.getFileDownload(
      bucketId: EnvVariables.recipeImagesBucketId,
      fileId: fileId,
    );

    final dir = await io.Directory.systemTemp.createTemp();
    final file = io.File('${dir.path}/$fileId.jpg');

    await file.writeAsBytes(response); // response is already Uint8List

    return file;
  }

  @override
  Future<void> updateRecipe(Recipe updatedRecipe, Recipe originalRecipe) async {
    final remoteImageId = updatedRecipe.isPlaceholder
        ? updatedRecipe.localImagePath
        : (updatedRecipe.localImagePath != null &&
                updatedRecipe.localImagePath != originalRecipe.localImagePath
            ? await _uploadRecipeImage(updatedRecipe.localImagePath!)
            : null);

    final newRecipe = updatedRecipe.copyWith(imagePath: remoteImageId);

    final response = await appWriteDB.updateDocument(
        databaseId: EnvVariables.dbId,
        collectionId: EnvVariables.recipeCollectionId,
        documentId: updatedRecipe.id,
        data: newRecipe.toJson());

    response.data.printPretty();
  }

  @override
  Future<void> deleteAll() async {
    final storage = Storage(locate<Client>());
    final response = await appWriteDB.listDocuments(
      databaseId: EnvVariables.dbId,
      collectionId: EnvVariables.recipeCollectionId,
    );

    for (appwrite.Document doc in response.documents) {
      await appWriteDB.deleteDocument(
        databaseId: EnvVariables.dbId,
        collectionId: EnvVariables.recipeCollectionId,
        documentId: doc.$id,
      );
      await storage.deleteFile(
        bucketId: EnvVariables.recipeImagesBucketId,
        fileId: doc.data["remoteFileId"],
      );
    }
  }
}
