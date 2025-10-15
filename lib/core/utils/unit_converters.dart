import 'package:recipeshopper/core/models/exceptions/ingredient_combination_exception.dart';
import 'package:recipeshopper/core/models/ingredient.dart';
import 'package:recipeshopper/core/models/units.dart';

sealed class Constants {
  static const double gramsPerKg = 1000;
  static const double mlPerLiter = 1000;
  static const double cupPerLiter = 4.167;
  static const double mlPerCup = 240;
  static const double mlPerTeaspoon = 4.92892;
  static const double mlPerTablespoon = 14.7868;
  static const double kgPerTeaspoons = 0.005;
  static const double kgPerTablespoons = 0.0015;
}

class UnitConverter {
  static const Map<(Unit, Unit), double> _conversionFactors = {
    (Unit.grams, Unit.kg): 1 / Constants.gramsPerKg,
    (Unit.teaspoons, Unit.kg): 1 / Constants.kgPerTeaspoons,
    (Unit.tablespoons, Unit.kg): 1 / Constants.kgPerTablespoons,
    (Unit.milliliters, Unit.liters): 1 / Constants.mlPerLiter,
    (Unit.cups, Unit.liters): 1 / Constants.cupPerLiter,
    (Unit.teaspoons, Unit.milliliters): 1 / Constants.mlPerTeaspoon,
    (Unit.tablespoons, Unit.milliliters): 1 / Constants.mlPerTablespoon,
    (Unit.milliliters, Unit.cups): 1 / Constants.mlPerCup,
    (Unit.cups, Unit.milliliters):  Constants.mlPerCup,

  };

  static bool canConvert(Unit from, Unit to) {
    return _conversionFactors.keys.contains((from, to));
  }

  /// converts the units of the [from] ingredient units to the [to] ingredient units.
  /// throws [IngredientCombinationException] if conversion is not supported
  static double convert(Ingredient from, Ingredient to) {
    if (!canConvert(from.unit, to.unit)) throw IngredientCombinationException("Cannot convert ingredient units: ${from.unit} and ${to.unit}");

    final key = (from.unit, to.unit);
    return from.quantity * _conversionFactors[key]!;
  }
}
