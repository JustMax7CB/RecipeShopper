// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ingredient _$IngredientFromJson(Map<String, dynamic> json) => Ingredient(
      id: json['id'] as String,
      name: json['name'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      unit: $enumDecode(_$UnitEnumMap, json['unit']),
    );

Map<String, dynamic> _$IngredientToJson(Ingredient instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'quantity': instance.quantity,
      'unit': _$UnitEnumMap[instance.unit]!,
    };

const _$UnitEnumMap = {
  Unit.kg: 'kg',
  Unit.liters: 'liters',
  Unit.pieces: 'pieces',
  Unit.cups: 'cups',
  Unit.teaspoons: 'teaspoons',
  Unit.tablespoons: 'tablespoons',
};
