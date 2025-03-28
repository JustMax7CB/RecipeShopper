import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipeshopper/extensions.dart';
import 'package:recipeshopper/ui/routes.dart';
import 'package:recipeshopper/ui/text_styles.dart';
import 'package:recipeshopper/ui/viewmodels/home_viewmodel.dart';
import 'package:recipeshopper/ui/views/home-screen/recipe_card.dart';
import 'package:recipeshopper/ui/widgets/svg_icon.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Load recipes when the screen is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeViewModel>().loadRecipes();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, __) {
        if (viewModel.isDeleteShown) viewModel.switchDeleteVisibility(false);
      },
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(8, 10, 8, 0),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: viewModel.isDeleteShown
                      ? Text(context.localized.backToRemoveDelete,
                          style: backFromDeleteModeTextStyle)
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(context.localized.recipes,
                                style: titleTextStyle),
                            Center(
                              child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, Routes.addRecipe.path);
                                  },
                                  child: SvgIcon(icon: LocalIcons.addRecipe)),
                            )
                          ],
                        ),
                ),
              ),
              Expanded(
                flex: 10,
                child: Consumer<HomeViewModel>(
                  builder: (context, viewModel, child) {
                    if (viewModel.isLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.amber,
                          strokeWidth: 2,
                        ),
                      );
                    }
                    if (viewModel.recipes.isEmpty) {
                      return Center(
                        child: Text(context.localized.noRecipes),
                      );
                    }
                    return RefreshIndicator(
                      key: widget.refreshIndicatorKey,
                      onRefresh: viewModel.loadRecipes,
                      triggerMode: RefreshIndicatorTriggerMode.anywhere,
                      child: GridView.builder(
                        padding: EdgeInsets.all(5),
                        physics: AlwaysScrollableScrollPhysics(),
                        itemCount: viewModel.recipes.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20),
                        itemBuilder: (context, index) {
                          return InkWell(
                              onLongPress: () =>
                                  viewModel.switchDeleteVisibility(true),
                              child: RecipeCard(
                                recipe: viewModel.recipes[index],
                                showDelete: viewModel.isDeleteShown,
                                deleteAction: (recipe) =>
                                    viewModel.deleteRecipe(recipe),
                              ));
                        },
                      ),
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
