import 'dart:convert';

import 'package:hive/hive.dart';

import 'ingredient_model.dart';

part 'recipe_model.g.dart';

@HiveType(typeId: 0)
class RecipeModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final List<IngredientModel> ingredients;

  RecipeModel(
      {required this.id, required this.name, required this.ingredients});

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    final ingredients = json["ingredients"] as List<String>;
    return RecipeModel(
        id: json["id"],
        name: json["name"],
        ingredients: ingredients
            .map((ingr) => IngredientModel.fromJson(jsonDecode(ingr)))
            .toList());
  }

  @override
  String toString() {
    return 'RecipeModel: [name: $name, ingredients: $ingredients]';
  }
}
