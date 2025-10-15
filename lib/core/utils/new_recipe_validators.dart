import 'package:flutter/cupertino.dart';
import 'package:recipeshopper/extensions.dart';

class NewRecipeValidators {


  static String? recipeNameValidator(String? value, BuildContext context) {
    return _isEmptyOrNullString(value) ? context.localized.emptyRecipeName : null;
  }

  static String? ingredientNameValidator(String? value, BuildContext context) {
    return _isEmptyOrNullString(value) ? context.localized.emptyIngredientName : null  ;
  }

  static String? ingredientAmountValidator(String? value, BuildContext context) {
    return _isEmptyOrNullString(value) ? context.localized.emptyIngredientAmount : null;
  }
  
  static bool _isEmptyOrNullString(String? value) {
    return value == null || value.isEmpty ;
  }
}