import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recipeshopper/core/models/recipe.dart';
import 'package:recipeshopper/core/services/prod/recipe_service_local.dart';
import 'package:recipeshopper/core/services/prod/recipe_service_remote.dart';
import 'package:recipeshopper/data/local/recipe_model.dart';

@lazySingleton
class RecipeRepository {
  final LocalRecipeService _localRecipeService; // Local
  final RemoteRecipeService _remoteRecipeService; // Remote

  RecipeRepository(this._localRecipeService, this._remoteRecipeService);

  ValueListenable<Box<RecipeModel>> listenToRecipeModels() {
    return _localRecipeService.listenToRecipeModels();
  }

  Future<Box<RecipeModel>> openAndGetRecipesBox() async {
    return await _localRecipeService.getBox();
  }

  Future<List<Recipe>> getLocalRecipes() async {
    debugPrint("==== Fetching local recipes");
    return _localRecipeService.getAllRecipes();
  }
  
  Future<void> synchronizeRecipes() async {
    final remoteRecipes = await _remoteRecipeService.getAllRecipes();
    final localRecipes = await getLocalRecipes();

    final areEqual = Set.from(remoteRecipes).length == Set.from(localRecipes).length &&
        Set.from(remoteRecipes).containsAll(localRecipes);
    if (areEqual) {
      debugPrint("===== Recipes are synchronized");
      return;
    }
    localRecipes.removeWhere((recipe) => remoteRecipes.contains(recipe));
    await _remoteRecipeService.saveRecipeBulk(localRecipes);

    remoteRecipes.removeWhere((recipe) => localRecipes.contains(recipe));
    await _localRecipeService.saveRecipeBulk(remoteRecipes);
    for (final remoteRecipe in remoteRecipes) {
      if (remoteRecipe.remoteFileId == null) continue;
      final image = await _remoteRecipeService.getRecipeImage(remoteRecipe.remoteFileId!);
      final localPath = await saveImageLocally(image);
      final updatedRecipe = remoteRecipe.copyWith(imagePath: localPath);
      await _localRecipeService.updateRecipe(updatedRecipe, remoteRecipe);
    }
  }

  Future<void> addRecipe(Recipe recipe) async {
    final savedRemotelyRecipe = await _remoteRecipeService.saveRecipe(recipe);
    await _localRecipeService.saveRecipe(savedRemotelyRecipe);
  }

  Future<String?> saveImageLocally(File selectedImage) async {
    final directory = await getApplicationDocumentsDirectory();
    final String path =
        "${directory.path}/${DateTime.now().millisecondsSinceEpoch}.jpg";
    final File newImage = await selectedImage.copy(path);
    return newImage.path;
  }

  Future<Recipe?> getRecipeById(String id) async {
    return await _localRecipeService.getRecipeById(id);
  }

  Future<void> deleteRecipe(String id) async {
    await _localRecipeService.deleteRecipe(id);
  }

  Future<Recipe> updateRecipe(
      Recipe updatedRecipe, Recipe originalRecipe) async {
    final recipe =
        await _localRecipeService.updateRecipe(updatedRecipe, originalRecipe);
    await _remoteRecipeService.updateRecipe(updatedRecipe, originalRecipe);
    return recipe;
  }

  Future<void> deleteAllRecipes() async {
    await _localRecipeService.deleteAll();
    await _remoteRecipeService.deleteAll();
  }
}
