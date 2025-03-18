import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recipeshopper/core/di/locator.dart';
import 'package:recipeshopper/core/services/mock/recipe_service_local.dart';
import 'package:recipeshopper/core/services/mock/recipe_service_remote.dart';
import 'package:recipeshopper/ui/views/add-recipe-screen/add_recipe_screen.dart';
import 'package:recipeshopper/ui/views/home-screen/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  setupLocator();

  runApp(MaterialApp(
    initialRoute: "/",
    routes: {
      "/": (context) => HomeScreen(
            localMockService: LocalRecipeServiceMock(),
            remoteMockService: RemoteRecipeServiceMock(),
          ),
      "/addRecipe": (context) => AddRecipeScreen(),
    },
    debugShowCheckedModeBanner: false,
  ));
}
