import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:recipeshopper/core/models/recipe.dart';

import '../../core/repositories/recipe_repository.dart';

@injectable
class HomeViewModel extends ChangeNotifier {
  HomeViewModel(this._recipeRepository);

  final RecipeRepository _recipeRepository;
  List<Recipe> _recipes = [];
  bool _isLoading = false;

  List<Recipe> get recipes => _recipes;

  bool get isLoading => _isLoading;

  void listenToChanges() async {
    (await _recipeRepository.recipeStream).listen((newRecipes) {
      _recipes = newRecipes;
      notifyListeners();
    });
  }

  Future<void> loadRecipes() async {
    _isLoading = true;
    notifyListeners();

    final recipesList = await _recipeRepository.getRecipes();
    _recipes = recipesList;

    _isLoading = false;
    notifyListeners();
  }

  Future<void> updateRecipes() async {
    _isLoading = true;
    notifyListeners();

    final recipeList = await _recipeRepository.getRecipes();
  }

  Future<void> createShoppingList() async {}
}
