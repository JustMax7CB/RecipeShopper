import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:recipeshopper/core/models/ingredient.dart';

@injectable
class ShoppingListViewModel extends ChangeNotifier {
  final List<Ingredient> _ingredients = [];

  int get ingredientCount => _ingredients.length;

  List<Ingredient> get ingredients => _ingredients;

  String ingredientString(int index) {
    final ingredient = _ingredients[index];
    return "${ingredient.name} - ${ingredient.quantity} ${ingredient.unit.name}";
  }

  List<Ingredient> getIngredientsFromRecipes() {
    return [];
  }
}
