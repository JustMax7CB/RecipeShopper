import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipeshopper/core/models/recipe.dart';
import 'package:recipeshopper/core/services/mock/recipe_service_local.dart';
import 'package:recipeshopper/core/services/mock/recipe_service_remote.dart';
import 'package:recipeshopper/core/services/recipe_service.dart';
import 'package:recipeshopper/ui/text_styles.dart';
import 'package:recipeshopper/ui/widgets/recipe_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required LocalRecipeServiceMock localMockService,
    required RemoteRecipeServiceMock remoteMockService,
  })  : localService = localMockService,
        remoteService = remoteMockService;

  final RecipeService localService;
  final RecipeService remoteService;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context),
      bottomNavigationBar: bottomNavBar(),
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
                        child: SvgPicture.asset(
                            "lib/assets/icons/add_recipe_icon.svg"),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 10,
                child: FutureBuilder<List<Recipe>>(
                  future: widget.localService.getAllRecipes(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.amber,
                          strokeWidth: 2,
                        ),
                      );
                    }
                    final recipeList =
                        [...?snapshot.data, ...?snapshot.data] ?? [];
                    // return RecipeCard(recipe: recipeList[0]);
                    return GridView.builder(
                      padding: EdgeInsets.all(5),
                      physics: BouncingScrollPhysics(),
                      itemCount: 10,
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

  Widget bottomNavBar() {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.09,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("lib/assets/images/appbar_bg.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Theme(
        data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent),
        child: BottomNavigationBar(
            showUnselectedLabels: false,
            onTap: (value) {
              setState(() {
                selectedIndex = value;
              });
            },
            currentIndex: selectedIndex,
            fixedColor: Colors.black,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                label: "Home",
                icon: Container(
                  padding: selectedIndex == 0 ? EdgeInsets.all(8) : null,
                  decoration: selectedIndex == 0
                      ? BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color.fromRGBO(217, 217, 217, 0.5),
                        )
                      : null,
                  child:
                      SvgPicture.asset("lib/assets/icons/home.svg", width: 20),
                ),
              ),
              BottomNavigationBarItem(
                label: "Search",
                icon: Container(
                    padding: selectedIndex == 1 ? EdgeInsets.all(8) : null,
                    decoration: selectedIndex == 1
                        ? BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Color.fromRGBO(217, 217, 217, 0.5),
                          )
                        : null,
                    child: SvgPicture.asset("lib/assets/icons/search.svg",
                        width: 20)),
              ),
              BottomNavigationBarItem(
                label: "Favorites",
                icon: Container(
                    padding: selectedIndex == 2 ? EdgeInsets.all(8) : null,
                    decoration: selectedIndex == 2
                        ? BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Color.fromRGBO(217, 217, 217, 0.5),
                          )
                        : null,
                    child: SvgPicture.asset("lib/assets/icons/favorites.svg",
                        width: 20)),
              ),
              BottomNavigationBarItem(
                label: "Settings",
                icon: Container(
                    padding: selectedIndex == 3 ? EdgeInsets.all(8) : null,
                    decoration: selectedIndex == 3
                        ? BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Color.fromRGBO(217, 217, 217, 0.5),
                          )
                        : null,
                    child: SvgPicture.asset("lib/assets/icons/settings.svg",
                        width: 20)),
              ),
              BottomNavigationBarItem(
                label: "Profile",
                icon: Container(
                    padding: selectedIndex == 4 ? EdgeInsets.all(8) : null,
                    decoration: selectedIndex == 4
                        ? BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Color.fromRGBO(217, 217, 217, 0.5),
                          )
                        : null,
                    child: SvgPicture.asset("lib/assets/icons/profile.svg",
                        width: 20)),
              ),
            ]),
      ),
    );
  }

  AppBar appbar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      actions: [
        Container(
          margin: EdgeInsets.only(right: 10),
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("lib/assets/images/appbar_bg.png"),
                fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Color(0xFF635648), width: 1),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.25),
                offset: Offset(1, 1),
                blurRadius: 1,
                spreadRadius: 1,
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: SvgPicture.asset(
              "lib/assets/icons/shopping_basket.svg",
              semanticsLabel: "Shopping Cart",
            ),
          ),
        )
      ],
      flexibleSpace: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/assets/images/appbar_bg.png"),
            fit: BoxFit.cover, // Ensure it covers the full space
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: SvgPicture.asset(
              "lib/assets/images/recipeshopper.svg",
              height: 45,
              width: 147,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
