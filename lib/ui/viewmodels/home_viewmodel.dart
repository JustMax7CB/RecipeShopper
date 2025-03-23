import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:recipeshopper/core/models/recipe.dart';
import 'package:recipeshopper/data/local/recipe_model.dart';
import 'package:recipeshopper/extensions.dart';

import '../../core/repositories/recipe_repository.dart';

@injectable
class HomeViewModel extends ChangeNotifier {
  HomeViewModel(this._recipeRepository);

  final RecipeRepository _recipeRepository;
  List<Recipe> _recipes = [];
  bool _isLoading = false;
  VoidCallback? _hiveListener;

  List<Recipe> get recipes => _recipes;

  bool get isLoading => _isLoading;

  ValueListenable<Box<RecipeModel>> get recipesListenable =>
      _recipeRepository.listenToRecipeModels();

  List<Recipe> getRecipes(Box<RecipeModel> box) {
    return box.values.map((model) => model.convertToRecipe()).toList();
  }

  Future<void> loadRecipes() async {
    _isLoading = true;
    notifyListeners();

    // Load recipes from repository (assuming it fetches from API or other source)
    final recipesList = await _recipeRepository.getRecipes();
    _recipes = recipesList;

    _isLoading = false;
    notifyListeners();

    // Listen to Hive box changes
    final box = await _recipeRepository.openAndGetRecipesBox();

    _hiveListener ??= () {
      _recipes = box.values.map((model) => model.convertToRecipe()).toList();
      notifyListeners();
    };
    box.listenable().addListener(_hiveListener!);
  }

  Future<void> createShoppingList() async {}
}
