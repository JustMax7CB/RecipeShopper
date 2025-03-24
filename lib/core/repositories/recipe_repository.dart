import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
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

  Future<List<Recipe>> getRecipes() async {
    return _localRecipeService.getAllRecipes();
  }

  Future<void> addRecipe(Recipe recipe) async {
    final savedRemotelyRecipe = await _remoteRecipeService.saveRecipe(recipe);
    await _localRecipeService.saveRecipe(savedRemotelyRecipe);
  }

  Future<Recipe?> getRecipeById(String id) async {
    return await _localRecipeService.getRecipeById(id);
  }

  Future<void> deleteRecipe(String id, String imageFileId) async {
    await _localRecipeService.deleteRecipe(id, imageFileId);
    await _remoteRecipeService.deleteRecipe(id, imageFileId);
  }

  Future<Recipe> updateRecipe(
      Recipe updatedRecipe, Recipe originalRecipe) async {
    final recipe =
        await _localRecipeService.updateRecipe(updatedRecipe, originalRecipe);
    await _remoteRecipeService.updateRecipe(updatedRecipe, originalRecipe);
    return recipe;
  }
}
