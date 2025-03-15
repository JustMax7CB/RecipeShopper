import 'package:recipeshopper/core/models/recipe.dart';
import 'package:recipeshopper/core/services/recipe_service.dart';

class RecipeRepository {
  final RecipeService _recipeService; // Local or Remote

  RecipeRepository(this._recipeService);

  Future<List<Recipe>> getRecipes() async {
    return _recipeService.getAllRecipes();
  }

  Future<void> addRecipe(Recipe recipe) async {
    await _recipeService.saveRecipe(recipe);
  }

  Future<Recipe?> getRecipeById(String id) async {
    return await _recipeService.getRecipeById(id);
  }

  Future<void> deleteRecipe(String id) async {
    await _recipeService.deleteRecipe(id);
  }

  Future<void> updateRecipe(Recipe updatedRecipe) async {
    await _recipeService.updateRecipe(updatedRecipe);
  }
}