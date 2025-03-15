import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:recipeshopper/core/models/local_entity.dart';

import 'ingredient.dart';

part 'recipe.g.dart';

@JsonSerializable()
class Recipe implements LocalEntity {
  final String id;
  final String name;
  final List<Ingredient> ingredients;
  final String imagePath;

  Recipe({required this.id, required this.name, required this.ingredients})
      : imagePath = "lib/assets/images/recipe_image.jpg";

  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeToJson(this);

  String get json => jsonEncode(toJson());

  @override
  String get key => id;

  @override
  String toString() {
    return 'Recipe: [name: $name, ingredients: $ingredients]';
  }
}
