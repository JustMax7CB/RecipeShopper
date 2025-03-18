import 'package:flutter/material.dart';
import 'package:recipeshopper/core/models/recipe.dart';
import 'package:recipeshopper/core/services/mock/recipe_service_local.dart';
import 'package:recipeshopper/core/services/mock/recipe_service_remote.dart';
import 'package:recipeshopper/core/services/recipe_service.dart';
import 'package:recipeshopper/ui/text_styles.dart';
import 'package:recipeshopper/ui/views/home-screen/home_app_bar.dart';
import 'package:recipeshopper/ui/views/home-screen/home_bottom_navbar.dart';
import 'package:recipeshopper/ui/widgets/recipe_card.dart';
import 'package:recipeshopper/ui/widgets/svg_icon.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required LocalRecipeServiceMock localMockService,
    required RemoteRecipeServiceMock remoteMockService,
  })  : localService = localMockService,
        remoteService = remoteMockService;

  final RecipeService localService;
  final RecipeService remoteService;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar() as PreferredSizeWidget,
      bottomNavigationBar: HomeBottomNavbar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(8, 10, 8, 0),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Recipes", style: titleTextStyle),
                      Center(
                        child: SvgIcon(icon: LocalIcons.addRecipe),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 10,
                child: FutureBuilder<List<Recipe>>(
                  future: localService.getAllRecipes(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.amber,
                          strokeWidth: 2,
                        ),
                      );
                    }
                    final recipeList = [...?snapshot.data];
                    return GridView.builder(
                      padding: EdgeInsets.all(5),
                      physics: BouncingScrollPhysics(),
                      itemCount: 5,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20),
                      itemBuilder: (context, index) {
                        return RecipeCard(recipe: recipeList[index]);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
