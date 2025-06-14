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
  final String? imagePath;
  final String? instructions;
  final String? remoteFileId;

  Recipe({
    required this.id,
    required this.name,
    required this.ingredients,
    this.instructions,
    this.imagePath,
    this.remoteFileId,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeToJson(this);

  String get json => jsonEncode(toJson());

  bool get isPlaceholder =>
      imagePath == null;

  Recipe copyWith(
          {String? name,
          String? imagePath,
          String? instructions,
          String? remoteFileId}) =>
      Recipe(
        id: id,
        name: name ?? this.name,
        ingredients: ingredients,
        instructions: instructions ?? this.instructions,
        imagePath: imagePath ?? this.imagePath,
        remoteFileId: remoteFileId ?? this.remoteFileId,
      );

  @override
  String get key => id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Recipe: [ID: $id, name: $name, ingredients: $ingredients, imagePath: $imagePath, remoteFileId: $remoteFileId]';
  }

  @override
  bool operator ==(Object other) {
    return id == (other as Recipe).id;
  }
}
