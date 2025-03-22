import 'dart:io';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recipeshopper/core/models/recipe.dart';
import 'package:recipeshopper/core/repositories/recipe_repository.dart';
import 'package:recipeshopper/ui/views/add-recipe-screen/ingredient_row.dart';
import 'package:uuid/uuid.dart';

@injectable
class AddRecipeViewModel extends ChangeNotifier {
  AddRecipeViewModel(this._recipeRepository);

  final RecipeRepository _recipeRepository;

  final Uuid uuid = Uuid();

  final List<IngredientRow> ingredients = [];
  final recipeNameController = TextEditingController();
  final recipeInstructionsController = TextEditingController();
  File? _selectedImage;

  File? get selectedImage => _selectedImage;

  set selectedImage(File? file) {
    _selectedImage = file;
    notifyListeners();
  }

  void removeIngredient(String id) {
    ingredients.removeWhere((ingredient) => ingredient.id == id);
    notifyListeners();
  }

  void addIngredient() {
    ingredients.add(IngredientRow(uuid.v4(), onDelete: removeIngredient));
    notifyListeners();
  }

  Future<void> createRecipe(String name) async {
    String? savedImagePath;
    if (_selectedImage != null) {
      savedImagePath = await _saveImageToLocal(_selectedImage!);
    }

    final recipe = Recipe(
        id: uuid.v4(),
        name: name,
        ingredients: ingredients.map((ingredient) => ingredient.model).toList(),
        imagePath: savedImagePath);

    await _recipeRepository.addRecipe(recipe);
  }

  // Function to save the file in the app's document directory
  Future<String> _saveImageToLocal(File imageFile) async {
    final directory = await getApplicationDocumentsDirectory();
    final String path =
        "${directory.path}/${DateTime.now().millisecondsSinceEpoch}.jpg";
    final File newImage = await imageFile.copy(path);
    return newImage.path;
  }
}
