import 'package:injectable/injectable.dart';
import 'package:recipeshopper/core/models/recipe.dart';
import 'package:recipeshopper/core/services/prod/recipe_service_local.dart';
import 'package:recipeshopper/core/services/prod/recipe_service_remote.dart';

@lazySingleton
class RecipeRepository {
  final LocalRecipeService _localRecipeService; // Local
  final RemoteRecipeService _remoteRecipeService; // Remote

  RecipeRepository(this._localRecipeService, this._remoteRecipeService);

  Future<Stream<List<Recipe>>> get recipeStream =>
      _localRecipeService.recipeStream;

  Future<List<Recipe>> getRecipes() async {
    return _localRecipeService.getAllRecipes();
  }

  Future<void> addRecipe(Recipe recipe) async {
    await _localRecipeService.saveRecipe(recipe);
  }

  Future<Recipe?> getRecipeById(String id) async {
    return await _localRecipeService.getRecipeById(id);
  }

  Future<void> deleteRecipe(String id) async {
    await _localRecipeService.deleteRecipe(id);
  }

  Future<void> updateRecipe(Recipe updatedRecipe) async {
    await _localRecipeService.updateRecipe(updatedRecipe);
  }
}
