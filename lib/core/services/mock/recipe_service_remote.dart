import 'package:injectable/injectable.dart';
import 'package:recipeshopper/core/models/ingredient.dart';
import 'package:recipeshopper/core/models/recipe.dart';
import 'package:recipeshopper/core/models/units.dart';
import 'package:recipeshopper/core/services/recipe_service.dart';

@Singleton(env: ["mock"])
class RemoteRecipeServiceMock implements RecipeService {
  static var recipe6 = Recipe(id: "6", name: "Pancakes", ingredients: [
    Ingredient(id: "1", name: "Flour", quantity: 0.25, unit: Unit.kg),
    Ingredient(id: "2", name: "Milk", quantity: 0.3, unit: Unit.liters),
    Ingredient(id: "3", name: "Eggs", quantity: 2, unit: Unit.units),
    Ingredient(id: "4", name: "Butter", quantity: 0.05, unit: Unit.kg),
    Ingredient(id: "5", name: "Sugar", quantity: 0.03, unit: Unit.kg)
  ]);

  static var recipe7 = Recipe(id: "7", name: "Tomato Soup", ingredients: [
    Ingredient(id: "1", name: "Tomatoes", quantity: 0.5, unit: Unit.kg),
    Ingredient(id: "2", name: "Onion", quantity: 1, unit: Unit.units),
    Ingredient(id: "3", name: "Garlic", quantity: 2, unit: Unit.units),
    Ingredient(
        id: "4", name: "Vegetable Broth", quantity: 0.5, unit: Unit.liters),
    Ingredient(id: "5", name: "Olive Oil", quantity: 0.02, unit: Unit.liters)
  ]);

  static var recipe8 = Recipe(id: "8", name: "Grilled Salmon", ingredients: [
    Ingredient(id: "1", name: "Salmon Fillet", quantity: 0.4, unit: Unit.kg),
    Ingredient(id: "2", name: "Lemon", quantity: 1, unit: Unit.units),
    Ingredient(id: "3", name: "Garlic", quantity: 2, unit: Unit.units),
    Ingredient(id: "4", name: "Olive Oil", quantity: 0.03, unit: Unit.liters),
    Ingredient(id: "5", name: "Salt", quantity: 0.01, unit: Unit.kg)
  ]);

  static var recipe9 =
      Recipe(id: "9", name: "Vegetable Stir Fry", ingredients: [
    Ingredient(id: "1", name: "Bell Peppers", quantity: 2, unit: Unit.units),
    Ingredient(id: "2", name: "Carrots", quantity: 1, unit: Unit.units),
    Ingredient(id: "3", name: "Broccoli", quantity: 0.3, unit: Unit.kg),
    Ingredient(id: "4", name: "Soy Sauce", quantity: 0.05, unit: Unit.liters),
    Ingredient(id: "5", name: "Tofu", quantity: 0.3, unit: Unit.kg)
  ]);

  static var recipe10 = Recipe(id: "10", name: "Chocolate Cake", ingredients: [
    Ingredient(id: "1", name: "Flour", quantity: 0.3, unit: Unit.kg),
    Ingredient(id: "2", name: "Cocoa Powder", quantity: 0.05, unit: Unit.kg),
    Ingredient(id: "3", name: "Eggs", quantity: 3, unit: Unit.units),
    Ingredient(id: "4", name: "Sugar", quantity: 0.2, unit: Unit.kg),
    Ingredient(id: "5", name: "Butter", quantity: 0.1, unit: Unit.kg)
  ]);

  @override
  Future<Recipe> saveRecipe(Recipe recipe) async {
    await Future.delayed(Duration(milliseconds: 1000));
    return recipe;
  }

  @override
  Future<void> deleteRecipe(String id, String imageFileId) async {
    await Future.delayed(Duration(milliseconds: 1000));
  }

  @override
  Future<List<Recipe>> getAllRecipes() async {
    return await Future.value([recipe6, recipe7, recipe8, recipe9, recipe10]);
  }

  @override
  Future<Recipe> getRecipeById(String id) async {
    await Future.delayed(Duration(milliseconds: 1000));
    return await Future.value(recipe6);
  }

  @override
  Future<void> updateRecipe(Recipe updatedRecipe, Recipe originalRecipe) async {
    await Future.delayed(Duration(milliseconds: 1000));
  }

  @override
  Future<void> deleteAll() async {
    await Future.delayed(Duration(milliseconds: 1000));
  }
}
