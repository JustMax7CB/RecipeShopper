import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:recipeshopper/extensions.dart';

part 'units.g.dart';

@HiveType(typeId: 2)
enum UnitEnum implements Comparable<UnitEnum> {
  @HiveField(0)
  kg("unit_kg"),
  @HiveField(1)
  grams("unit_grams"),
  @HiveField(2)
  liters("unit_liters"),
  @HiveField(3)
  milliliters("unit_ml"),
  @HiveField(4)
  units("unit_units"),
  @HiveField(5)
  cups("unit_cups"),
  @HiveField(6)
  teaspoons("unit_teaspoons"),
  @HiveField(7)
  tablespoons("unit_tablespoons");

  String getLocalizedName(BuildContext context) {
    switch (localizationKey) {
      case 'unit_kg':
        return context.localized.unit_kg;
      case 'unit_grams':
        return context.localized.unit_grams;
      case 'unit_liters':
        return context.localized.unit_liters;
      case 'unit_ml':
        return context.localized.unit_ml;
      case 'unit_units':
        return context.localized.unit_units;
      case 'unit_cups':
        return context.localized.unit_cups;
      case 'unit_teaspoons':
        return context.localized.unit_teaspoons;
      case 'unit_tablespoons':
        return context.localized.unit_tablespoons;
      default:
        throw UnimplementedError(
            'Localization for $localizationKey not implemented');
    }
  }

  @override
  int compareTo(UnitEnum other) {
    throw UnimplementedError();
  }

  final String localizationKey;

  const UnitEnum(this.localizationKey);
}
