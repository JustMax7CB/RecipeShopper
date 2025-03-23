import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:recipeshopper/core/di/locator.dart';
import 'package:recipeshopper/core/models/recipe.dart';
import 'package:recipeshopper/extensions.dart';
import 'package:recipeshopper/ui/viewmodels/viewmodels_export.dart';
import 'package:recipeshopper/ui/views/views_export.dart';

import 'locale_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  setupLocator();

  runApp(
    ChangeNotifierProvider(
      create: (_) => LocaleProvider(),
      child: Consumer<LocaleProvider>(
        builder: (context, localeProvider, child) => MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: localeProvider.locale,
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
            "/recipe": (_) =>
                RecipeScreen(ModalRoute.of(_)!.settings.arguments as Recipe)
          },
          debugShowCheckedModeBanner: false,
          builder: (context, child) => Directionality(
            textDirection: Localizations.localeOf(context).direction(context),
            child: child!,
          ),
        ),
      ),
    ),
  );
}
