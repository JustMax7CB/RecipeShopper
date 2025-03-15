import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:recipeshopper/core/models/ingredient.dart';
import 'package:recipeshopper/core/models/recipe.dart';
import 'package:recipeshopper/core/models/units.dart';
import 'package:recipeshopper/data/local/ingredient_model.dart';
import 'package:recipeshopper/data/local/recipe_model.dart';
import 'package:recipeshopper/data/local/units.dart';

extension DocumentLog on Map<String, dynamic> {
  void printPretty() {
    final encoder = JsonEncoder.withIndent('  '); // Indented JSON output
    debugPrint(encoder.convert(this));
  }
}

extension RecipeToModel on Recipe {
  RecipeModel convertRecipeToModel() => RecipeModel(
        id: id,
        name: name,
        ingredients: ingredients
            .map((ingredient) => _convertIngredientToModel(ingredient))
            .toList(),
      );

  IngredientModel _convertIngredientToModel(Ingredient ingredient) =>
      IngredientModel(
        id: ingredient.id,
        name: ingredient.name,
        quantity: ingredient.quantity,
        unit: _convertUnitToModel(ingredient.unit),
      );

  UnitEnum _convertUnitToModel(Unit unit) => UnitEnum.values.firstWhere(
        (u) => u.name == unit.name,
      );
}

extension RecipeModelToRecipe on RecipeModel {
  Recipe convertToRecipe() => Recipe(
        id: id,
        name: name,
        ingredients:
            ingredients.map((model) => _convertToIngredient(model)).toList(),
      );

  Ingredient _convertToIngredient(IngredientModel model) => Ingredient(
        id: model.id,
        name: model.name,
        quantity: model.quantity,
        unit: _convertToUnit(model.unit),
      );

  Unit _convertToUnit(UnitEnum unum) =>
      Unit.values.firstWhere((e) => e.name == unum.name);
}
