import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:recipeshopper/core/models/local_entity.dart';
import 'package:recipeshopper/core/utils/unit_converters.dart';

import 'units.dart';

part 'ingredient.g.dart';

@JsonSerializable()
class Ingredient implements LocalEntity {
  final String id;
  final String name;
  final double quantity;
  final Unit unit;

  Ingredient({
    required this.id,
    required this.name,
    required this.quantity,
    required this.unit,
  });

  Ingredient addQuantity(double quantity) {
    return Ingredient(
        id: id, name: name, quantity: this.quantity + quantity, unit: unit);
  }

  factory Ingredient.fromJson(Map<String, dynamic> json) =>
      _$IngredientFromJson(json);

  factory Ingredient.fromJsonString(String jsonString) =>
      Ingredient.fromJson(jsonDecode(jsonString));

  String toJson() => json.encode(_$IngredientToJson(this));

  Ingredient operator +(Ingredient other) {
    if (unit == other.unit) return addQuantity(other.quantity);

    final convertedQuantity = UnitConverter.convert(other, this);
    return addQuantity(convertedQuantity);

  }


  @override
  String get key => id;

  @override
  String toString() {
    return "Ingredient: [id: $id, name: $name, quantity: $quantity, unit: $unit]";
  }
}
