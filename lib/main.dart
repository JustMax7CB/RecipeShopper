import 'package:flutter/material.dart';
import 'package:flutter_bugfender/flutter_bugfender.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:recipeshopper/core/di/locator.dart';
import 'package:recipeshopper/core/models/recipe.dart';
import 'package:recipeshopper/environment.dart';
import 'package:recipeshopper/extensions.dart';
import 'package:recipeshopper/ui/routes.dart';
import 'package:recipeshopper/ui/viewmodels/viewmodels_export.dart';
import 'package:recipeshopper/ui/views/views_export.dart';

import 'locale_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterBugfender.init("pzLhvaHX2w06g9eTel51MqihKV1f4NdK",
      enableCrashReporting: true, // these are optional, but recommended
      enableUIEventLogging: false,
      enableAndroidLogcatLogging: false);
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  await setupLocator();

  final localeProvider = await LocaleProvider.create();

  EnvVariables().checkIds();

  runApp(
    ChangeNotifierProvider(
      create: (_) => localeProvider,
      child: Consumer<LocaleProvider>(
        builder: (context, localeProvider, child) {
          return MaterialApp(
            theme: ThemeData(fontFamily: localeProvider.fontFamily),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: localeProvider.locale,
            initialRoute: Routes.main.path,
            routes: {
              Routes.main.path: (_) => ChangeNotifierProvider(
                    create: (_) => locate<MainViewModel>(),
                    child: MainScreen(),
                  ),
              Routes.addRecipe.path: (ctx) => ChangeNotifierProvider(
                    create: (_) => locate<AddRecipeViewModel>(),
                    child: AddRecipeScreen(recipe: ctx.getArgument<Recipe?>()),
                  ),
              Routes.recipe.path: (ctx) =>
                  RecipeScreen(ctx.getArgument<Recipe>()!),
            },
            debugShowCheckedModeBanner: false,
            builder: (context, child) => Directionality(
              textDirection: Localizations.localeOf(context).direction(context),
              child: child!,
            ),
          );
        },
      ),
    ),
  );
}
