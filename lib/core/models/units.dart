import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:recipeshopper/extensions.dart';

enum Unit implements Comparable<Unit> {
  @JsonValue("kg")
  kg("kg"),

  @JsonValue("grams")
  grams("grams"),

  @JsonValue("liters")
  liters("liters"),

  @JsonValue("ml")
  milliliters("ml"),

  @JsonValue("units")
  units("units"),

  @JsonValue("cups")
  cups("cups"),

  @JsonValue("teaspoons")
  teaspoons("teaspoons"),

  @JsonValue("tablespoons")
  tablespoons("tablespoons");

  @override
  int compareTo(Unit other) {
    throw UnimplementedError();
  }

  String getLocalizedName(BuildContext context) {
    switch (localizationKey) {
      case 'kg':
        return context.localized.unit_kg;
      case 'grams':
        return context.localized.unit_grams;
      case 'liters':
        return context.localized.unit_liters;
      case 'ml':
        return context.localized.unit_ml;
      case 'units':
        return context.localized.unit_units;
      case 'cups':
        return context.localized.unit_cups;
      case 'teaspoons':
        return context.localized.unit_teaspoons;
      case 'tablespoons':
        return context.localized.unit_tablespoons;
      default:
        throw UnimplementedError(
            'Localization for $localizationKey not implemented');
    }
  }

  final String localizationKey;
  const Unit(this.localizationKey);
}
