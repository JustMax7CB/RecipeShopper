import 'package:flutter/material.dart';
import 'package:recipeshopper/ui/colors.dart';
import 'package:recipeshopper/ui/extensions.dart';

final _kalamTextStyle = TextStyle(fontFamily: "Kalam");

final TextStyle titleTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 32,
    fontWeight: FontWeight.w600,
    fontFamily: "Kalam",
    shadows: [
      Shadow(
        color: AppColors.titleShadowColor,
        blurRadius: 4,
        offset: Offset(1, 2),
      )
    ]).withStroke(0.7, Colors.black);

final TextStyle backFromDeleteModeTextStyle = titleTextStyle.copyWith(fontSize: 20, shadows: null);

final recipeNameTextStyle =
    _kalamTextStyle.copyWith(fontSize: 15, fontWeight: FontWeight.w400);

final fieldHintTextStyle = _kalamTextStyle.copyWith(
    fontSize: 12, color: AppColors.textFieldHintColor, fontWeight: FontWeight.w400);

final newRecipeSectionTitle = _kalamTextStyle.copyWith(
    fontSize: 20, color: Colors.black, fontWeight: FontWeight.w400);

final newRecipeAddIngredientTextStyle = _kalamTextStyle.copyWith(
    fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400);

final newRecipeSaveButtonTextStyle =
    _kalamTextStyle.copyWith(fontSize: 20, letterSpacing: 0.1);

final recipeIngredientsTitleTextStyle = _kalamTextStyle.copyWith(
  fontSize: 18,
  fontWeight: FontWeight.w400
);

final recipeIngredientsTextStyle = _kalamTextStyle.copyWith(
  fontSize: 16,
  height:1.4
);