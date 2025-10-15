import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:recipeshopper/core/models/exceptions/ingredient_combination_exception.dart';
import 'package:recipeshopper/core/models/ingredient.dart';
import 'package:recipeshopper/core/models/recipe.dart';

@injectable
class ShoppingListViewModel extends ChangeNotifier {
  final List<Recipe> _recipes = [];
  final List<Ingredient> _ingredients = [];

  int get ingredientCount => _ingredients.length;

  List<Ingredient> get ingredients => _ingredients;

  String ingredientString(int index) {
    final ingredient = _ingredients[index];
    return "${ingredient.name} - ${ingredient.quantity} ${ingredient.unit.name}";
  }

  void resolveIngredientsFromRecipes() {
    var allIngredients =
        _recipes.expand((recipe) => recipe.ingredients).toList();

    final Map<String, Ingredient> combined = {};

    for (final ingredient in allIngredients) {
      final key = ingredient.name.toLowerCase();

      if (combined.containsKey(key)) {
        try {
          combined[key] = combined[key]! + ingredient;
        } on IngredientCombinationException catch (e) {
          // Handle non-convertible units by skipping or logging
          debugPrint("Skipping incompatible ingredient: $e");
        }
      } else {
        combined[key] = ingredient;
      }
    }

    _ingredients
      ..clear()
      ..addAll(combined.values);

   }

  void toggleRecipe(Recipe recipe) {
    if (!_recipes.contains(recipe)) {
      _recipes.add(recipe);
    } else {
      _recipes.remove(recipe);
    }
    notifyListeners();
  }

  bool containsRecipe(Recipe recipe) {
    return _recipes.contains(recipe);
  }
}
