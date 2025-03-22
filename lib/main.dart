import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:recipeshopper/core/di/locator.dart';
import 'package:recipeshopper/core/models/recipe.dart';
import 'package:recipeshopper/ui/viewmodels/add_recipe_viewmodel.dart';
import 'package:recipeshopper/ui/viewmodels/home_viewmodel.dart';
import 'package:recipeshopper/ui/views/add-recipe-screen/add_recipe_screen.dart';
import 'package:recipeshopper/ui/views/home-screen/home_screen.dart';
import 'package:recipeshopper/ui/views/recipe-screen/recipe_screen.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  setupLocator();

  runApp(
    MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (_) => ChangeNotifierProvider(
              create: (_) => locate<HomeViewModel>(),
              child: HomeScreen(),
            ),
        "/addRecipe": (_) => ChangeNotifierProvider(
              create: (_) => locate<AddRecipeViewModel>(),
              child: AddRecipeScreen(),
            ),
        "/recipe": (_) => RecipeScreen(ModalRoute.of(_)!.settings.arguments as Recipe)
      },
      debugShowCheckedModeBanner: false,
    ),
  );
}
