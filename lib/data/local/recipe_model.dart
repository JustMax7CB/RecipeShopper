import 'dart:convert';
import 'dart:io';

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

  @HiveField(3)
  final String? imagePath;

  RecipeModel(
      {required this.id,
      required this.name,
      required this.ingredients,
      this.imagePath});

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    final ingredients = json["ingredients"] as List<String>;
    return RecipeModel(
        id: json["id"],
        name: json["name"],
        ingredients: ingredients
            .map((ingredient) =>
                IngredientModel.fromJson(jsonDecode(ingredient)))
            .toList(),
        imagePath: json["imagePath"]);
  }

  @override
  String toString() {
    return 'RecipeModel: [name: $name, ingredients: $ingredients]';
  }
}
