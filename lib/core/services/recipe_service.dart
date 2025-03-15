import '../models/recipe.dart';

abstract class RecipeService {

  Future<List<Recipe>> getAllRecipes();
  Future<Recipe?> getRecipeById(String id);
  Future<void> saveRecipe(Recipe recipe);
  Future<void> updateRecipe(Recipe updatedRecipe);
  Future<void> deleteRecipe(String id);

}