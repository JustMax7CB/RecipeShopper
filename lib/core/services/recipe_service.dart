import '../models/recipe.dart';

abstract class RecipeService {
  Future<List<Recipe>> getAllRecipes();
  Future<Recipe?> getRecipeById(String id);
  Future<Recipe> saveRecipe(Recipe recipe);
  Future<void> updateRecipe(Recipe updatedRecipe, Recipe originalRecipe);
  Future<void> deleteRecipe(String id, String imageFileId);
  Future<void> deleteAll();
}
