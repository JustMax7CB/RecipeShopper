import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:recipeshopper/core/models/recipe.dart';
import 'package:recipeshopper/core/services/recipe_service.dart';
import 'package:recipeshopper/data/local/ingredient_model.dart';
import 'package:recipeshopper/data/local/recipe_model.dart';
import 'package:recipeshopper/data/local/units.dart';
import 'package:recipeshopper/extensions.dart';

@Singleton()
class LocalRecipeService implements RecipeService {
  static const String _boxName = 'recipeBox';

  LocalRecipeService() {
    init().then((_) => print("Initialized Local Recipe Service"));
  }

  bool isBoxOpen() {
    try {
      return Hive.box(_boxName).isOpen;
    } on Exception catch (_) {
      return false;
    }
  }

  Future<Box<RecipeModel>> getBox() async {
    final box = await Hive.openBox<RecipeModel>(_boxName);
    return box;
  }

  Future<void> init() async {
    // Initialize Hive and register the adapter
    _registerHiveAdapters();
    await Hive.openBox<RecipeModel>(_boxName);
  }

  @override
  Future<List<Recipe>> getAllRecipes() async {
    await Hive.openBox<RecipeModel>(_boxName);

    final box = Hive.box<RecipeModel>(_boxName);
    return box.values.map((r) => r.convertToRecipe()).toList();
  }

  ValueListenable<Box<RecipeModel>> listenToRecipeModels() {
    return Hive.box<RecipeModel>(_boxName).listenable();
  }

  @override
  Future<Recipe?> getRecipeById(String id) async {
    final box = Hive.box<RecipeModel>(_boxName);
    return box.get(id)?.convertToRecipe();
  }

  @override
  Future<Recipe> saveRecipe(Recipe recipe) async {
    final box = Hive.box<RecipeModel>(_boxName);
    await box.put(recipe.id, recipe.convertRecipeToModel());
    return recipe;
  }

  @override
  Future<Recipe> updateRecipe(Recipe recipe, Recipe original) async {
    final box = Hive.box<RecipeModel>(_boxName);
    if (box.containsKey(recipe.id)) {
      await box.put(recipe.id, recipe.convertRecipeToModel());
      return recipe;
    } else {
      throw Exception(
          "Recipe with ID ${recipe.id} not found in local storage.");
    }
  }

  @override
  Future<void> deleteRecipe(String id, String imageFileId) async {
    final box = Hive.box<RecipeModel>(_boxName);
    await box.delete(id);
  }

  Future<void> clearAllRecipes() async {
    final box = Hive.box<RecipeModel>(_boxName);
    await box.deleteAll(box.keys);
  }

  void _registerHiveAdapters() {
    Hive.registerAdapter(UnitEnumAdapter());
    Hive.registerAdapter(IngredientModelAdapter());
    Hive.registerAdapter(RecipeModelAdapter());
  }
}
