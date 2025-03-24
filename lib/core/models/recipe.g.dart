// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recipe _$RecipeFromJson(Map<String, dynamic> json) => Recipe(
      id: json['id'] as String,
      name: json['name'] as String,
      ingredients: (json['ingredients'] as List<dynamic>)
          .map((e) => Ingredient.fromJson(e as Map<String, dynamic>))
          .toList(),
      instructions: json['instructions'] as String?,
      imagePath: json['imagePath'] as String?,
      remoteFileId: json['remoteFileId'] as String?,
    );

Map<String, dynamic> _$RecipeToJson(Recipe instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'ingredients': instance.ingredients,
      'imagePath': instance.imagePath,
      'instructions': instance.instructions,
      'remoteFileId': instance.remoteFileId,
    };
