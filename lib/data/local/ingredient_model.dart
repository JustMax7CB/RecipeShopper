import 'package:hive/hive.dart';
import 'package:recipeshopper/data/local/units.dart';
part 'ingredient_model.g.dart';

@HiveType(typeId: 1)
class IngredientModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final double quantity;

  @HiveField(3)
  final UnitEnum unit;

  IngredientModel({
    required this.id,
    required this.name,
    required this.quantity,
    required this.unit,
  });

  IngredientModel addQuantity(double quantity) {
    return IngredientModel(
        id: id, name: name, quantity: this.quantity + quantity, unit: unit);
  }

  factory IngredientModel.fromJson(
          Map<String, dynamic> json) =>
      IngredientModel(
          id: json["id"],
          name: json["name"],
          quantity: json["quantity"],
          unit:
              UnitEnum.values.firstWhere((unit) => json["unit"] == unit.name));

  @override
  String toString() {
    return "IngredientModel: [name: $name, quantity: $quantity, unit: $unit]";
  }
}
