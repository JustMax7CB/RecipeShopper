import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bugfender/flutter_bugfender.dart';
import 'package:injectable/injectable.dart';
import 'package:recipeshopper/core/models/recipe.dart';
import 'package:recipeshopper/core/repositories/recipe_repository.dart';
import 'package:recipeshopper/ui/views/add-recipe-screen/ingredient_row.dart';
import 'package:uuid/uuid.dart';

@injectable
class AddRecipeViewModel extends ChangeNotifier {
  AddRecipeViewModel(this._recipeRepository);

  final RecipeRepository _recipeRepository;

  final Uuid uuid = Uuid();

  Recipe? _originalRecipe;
  Recipe? _updatedRecipe;
  final List<IngredientRow> ingredients = [];
  final recipeNameController = TextEditingController();
  final recipeInstructionsController = TextEditingController();
  File? _selectedImage;

  File? get selectedImage => _selectedImage;

  bool get isUpdate => _originalRecipe != null;

  Recipe? get updatedRecipe => _updatedRecipe;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set selectedImage(File? file) {
    _selectedImage = file;
    notifyListeners();
  }

  void _clearIngredients() {
    ingredients.clear();
  }

  void loadRecipe(Recipe recipe) {
    debugPrint("===== loading recipe: $recipe");
    FlutterBugfender.debug(
        "=== [AddRecipeViewModel]  Loading recipe ${recipe.id} ${recipe.name}");
    _originalRecipe = _updatedRecipe = recipe;
    _clearIngredients();

    recipeNameController.text = _originalRecipe!.name;
    recipeInstructionsController.text = _originalRecipe?.instructions ?? "";
    if (recipe.localImagePath != null) {
      _selectedImage = File(_originalRecipe!.localImagePath!);
    }
    ingredients.addAll(
      _originalRecipe!.ingredients.map((ingredient) => IngredientRow(
            ingredient.id,
            onDelete: removeIngredient,
            name: ingredient.name,
            amount: ingredient.quantity,
            unit: ingredient.unit,
          )),
    );
  }

  void removeIngredient(String id) {
    debugPrint("==== Removing ingredient with id: $id");
    ingredients.removeWhere((ingredient) => ingredient.id == id);
    notifyListeners();
  }

  void addIngredient() {
    ingredients.add(IngredientRow(uuid.v4(), onDelete: removeIngredient));
    notifyListeners();
  }

  Future<Recipe?> updateRecipe() async {
    FlutterBugfender.debug(
        "=== [AddRecipeViewModel]  Updating recipe ${_originalRecipe!.id} ${recipeNameController.text}");
    _isLoading = true;
    notifyListeners();

    try {
      String? savedImagePath = _originalRecipe?.localImagePath;
      if (_selectedImage != null &&
          _selectedImage!.path != _originalRecipe!.localImagePath) {
        savedImagePath = await _recipeRepository.saveImageLocally(_selectedImage!);
      }

      final updatedRecipe = Recipe(
          id: _originalRecipe!.id,
          name: recipeNameController.text,
          ingredients:
              ingredients.map((ingredient) => ingredient.model).toList(),
          localImagePath: savedImagePath,
          instructions: recipeInstructionsController.text);

      return await _recipeRepository.updateRecipe(
          updatedRecipe, _originalRecipe!);
    } on Exception catch (e) {
      debugPrint('===== Exception: $e');
      FlutterBugfender.error(e.toString());
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Recipe?> createRecipe() async {
    FlutterBugfender.debug(
        "=== [AddRecipeViewModel]  Creating recipe ${recipeNameController.text}");

    _isLoading = true;
    notifyListeners();

    try {
      String? savedImagePath;
      if (_selectedImage != null) {
        savedImagePath = await _recipeRepository.saveImageLocally(_selectedImage!);
      }

      final recipe = Recipe(
          id: uuid.v4(),
          name: recipeNameController.text,
          ingredients: ingredients.any((ingredientRow) => ingredientRow.isEmpty) ? [] :
              ingredients.map((ingredient) => ingredient.model).toList(),
          localImagePath: savedImagePath,
          instructions: recipeInstructionsController.text);

      FlutterBugfender.debug(
          "=== [AddRecipeViewModel]  Storing recipe: $recipe");
      await _recipeRepository.addRecipe(recipe);
      return recipe;
    } on Exception catch (e) {
      debugPrint('===== Exception: $e');
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
