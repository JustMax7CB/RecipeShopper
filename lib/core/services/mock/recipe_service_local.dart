import 'package:injectable/injectable.dart';
import 'package:recipeshopper/core/models/ingredient.dart';
import 'package:recipeshopper/core/models/recipe.dart';
import 'package:recipeshopper/core/models/units.dart';
import 'package:recipeshopper/core/services/recipe_service.dart';

@Singleton(env: ["mock"])
class LocalRecipeServiceMock implements RecipeService {
  static var recipe1 =
      Recipe(id: "1", name: "Spaghetti Carbonara", ingredients: [
    Ingredient(id: "1", name: "Guanciale", quantity: 0.3, unit: Unit.kg),
    Ingredient(id: "2", name: "Spaghetti", quantity: 0.4, unit: Unit.kg),
    Ingredient(id: "3", name: "Eggs", quantity: 3, unit: Unit.units),
    Ingredient(
        id: "4", name: "Parmigiano Reggiano", quantity: 0.1, unit: Unit.kg)
  ]);

  static var recipe2 = Recipe(id: "2", name: "Chicken Alfredo", ingredients: [
    Ingredient(id: "1", name: "Chicken Breast", quantity: 0.5, unit: Unit.kg),
    Ingredient(id: "2", name: "Fettuccine", quantity: 0.4, unit: Unit.kg),
    Ingredient(id: "3", name: "Heavy Cream", quantity: 0.2, unit: Unit.liters),
    Ingredient(id: "4", name: "Parmesan Cheese", quantity: 0.15, unit: Unit.kg),
    Ingredient(id: "5", name: "Butter", quantity: 0.05, unit: Unit.kg)
  ]);

  static var recipe3 = Recipe(id: "3", name: "Margherita Pizza", ingredients: [
    Ingredient(id: "1", name: "Pizza Dough", quantity: 1, unit: Unit.units),
    Ingredient(id: "2", name: "Tomato Sauce", quantity: 0.2, unit: Unit.liters),
    Ingredient(id: "3", name: "Mozzarella", quantity: 0.3, unit: Unit.kg),
    Ingredient(id: "4", name: "Fresh Basil", quantity: 5, unit: Unit.units),
    Ingredient(id: "5", name: "Olive Oil", quantity: 0.02, unit: Unit.liters)
  ]);

  static var recipe4 = Recipe(id: "4", name: "Caesar Salad", ingredients: [
    Ingredient(id: "1", name: "Romaine Lettuce", quantity: 1, unit: Unit.units),
    Ingredient(
        id: "2", name: "Caesar Dressing", quantity: 0.1, unit: Unit.liters),
    Ingredient(id: "3", name: "Croutons", quantity: 0.15, unit: Unit.kg),
    Ingredient(id: "4", name: "Parmesan Cheese", quantity: 0.1, unit: Unit.kg),
    Ingredient(id: "5", name: "Chicken Breast", quantity: 0.3, unit: Unit.kg)
  ]);

  static var recipe5 = Recipe(id: "5", name: "Beef Tacos", ingredients: [
    Ingredient(id: "1", name: "Ground Beef", quantity: 0.5, unit: Unit.kg),
    Ingredient(id: "2", name: "Taco Shells", quantity: 6, unit: Unit.units),
    Ingredient(id: "3", name: "Lettuce", quantity: 0.2, unit: Unit.kg),
    Ingredient(id: "4", name: "Cheddar Cheese", quantity: 0.15, unit: Unit.kg),
    Ingredient(id: "5", name: "Salsa", quantity: 0.1, unit: Unit.liters)
  ]);

  @override
  Future<void> saveRecipe(Recipe recipe) async {
    await Future.delayed(Duration(milliseconds: 1000));
  }

  @override
  Future<void> deleteRecipe(String id) async {
    await Future.delayed(Duration(milliseconds: 1000));
  }

  @override
  Future<List<Recipe>> getAllRecipes() async {
    await Future.delayed(Duration(milliseconds: 2500));
    return await Future.value([recipe1, recipe2, recipe3, recipe4, recipe5]);
  }

  @override
  Future<Recipe> getRecipeById(String id) async {
    await Future.delayed(Duration(milliseconds: 2000));
    return await Future.value(recipe1);
  }

  @override
  Future<void> updateRecipe(Recipe updatedRecipe) async {
    await Future.delayed(Duration(milliseconds: 1000));
  }
}
