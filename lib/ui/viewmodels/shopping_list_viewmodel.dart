import 'package:flutter/material.dart';
import 'package:recipeshopper/core/models/ingredient.dart';
import 'package:recipeshopper/core/models/recipe.dart';

class ShoppingListViewModel extends ChangeNotifier {

  final List<Recipe> _recipes = [];

  List<Ingredient> getIngredientsFromRecipes() {
    return [];
  }



}