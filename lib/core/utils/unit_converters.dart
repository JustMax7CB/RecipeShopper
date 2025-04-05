sealed class Constants {
  static const double gramsPerKg = 1000;
  static const double mlPerLiter = 1000;
  static const double literPerCup = 4.167;
  static const double mlPerCup = 240;
  static const double mlPerTeaspoon = 4.92892;
  static const double mlPerTablespoon = 14.7868;
  static const double gramsPerTeaspoons = 5;
  static const double gramsPerTablespoons = 15;
}

sealed class UnitConverters {
  double _convertTeaspoonsToGrams(double amount) =>
      amount * Constants.gramsPerTeaspoons;

  double _convertTablespoonsToGrams(double amount) =>
      amount * Constants.gramsPerTablespoons;

  double _convertKgToGrams(double amount) => amount * Constants.gramsPerKg;

  double _convertGramsToKg(double amount) => amount / Constants.gramsPerKg;

  double _convertMillilitersToCups(double amount) =>
      amount / Constants.mlPerCup;

  double _convertCupsToLiters(double amount) => amount * Constants.literPerCup;
}
