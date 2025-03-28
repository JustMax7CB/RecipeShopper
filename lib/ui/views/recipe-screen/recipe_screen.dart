import 'dart:io';

import 'package:flutter/material.dart';
import 'package:recipeshopper/core/models/recipe.dart';
import 'package:recipeshopper/extensions.dart';
import 'package:recipeshopper/ui/colors.dart';
import 'package:recipeshopper/ui/routes.dart';
import 'package:recipeshopper/ui/text_styles.dart';
import 'package:recipeshopper/ui/widgets/image_resource.dart';
import 'package:recipeshopper/ui/widgets/svg_icon.dart';

class RecipeScreen extends StatelessWidget {
  const RecipeScreen(this._recipe, {super.key});

  final Recipe _recipe;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_sharp,
            size: 25,
            color: Colors.white,
            shadows: [
              Shadow(color: Colors.black, offset: Offset(1, 1), blurRadius: 5)
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.share,
              size: 25,
              color: Colors.white,
              shadows: [
                Shadow(color: Colors.black, offset: Offset(0, 1), blurRadius: 8)
              ],
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    // Recipe Image Header
                    Stack(
                      children: [
                        imageWidget(),
                        Positioned(
                          bottom: 8,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 14),
                            width: MediaQuery.sizeOf(context).width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                    child: Text(
                                  _recipe.name,
                                  style: titleTextStyle,
                                  softWrap: true,
                                )),
                                OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor:
                                        AppColors.recipeEditBtnBgColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      side: BorderSide(
                                          color: Colors.black, width: 0.6),
                                    ),
                                  ),
                                  onPressed: () =>
                                      Navigator.pushReplacementNamed(
                                          context, Routes.addRecipe.path,
                                          arguments: _recipe),
                                  child: SvgIcon(
                                    icon: LocalIcons.pencil,
                                    width: 22,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Recipe Content
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: ImageResource(ImageRes.fadedWood),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 12.0, top: 36, right: 12.0, bottom: 12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(context.localized.ingredients,
                                  style: recipeIngredientsTitleTextStyle),
                              SizedBox(height: 8),
                              ..._recipe.ingredients.map(
                                (ingredient) => Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    "• ${ingredient.quantity} ${ingredient.unit.getLocalizedName(context)} ${ingredient.name}",
                                    style: recipeIngredientsTextStyle,
                                  ),
                                ),
                              ),
                              if (_recipe.instructions != null &&
                                  _recipe.instructions!.isNotEmpty)
                                instructions(context)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget instructions(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30),
          Text(context.localized.instructions,
              style: recipeIngredientsTitleTextStyle),
          SizedBox(height: 8),
          Text(
            _recipe.instructions!,
            style: recipeIngredientsTextStyle,
          ),
        ],
      );

  Widget imageWidget() => _recipe.isPlaceholder
      ? Container(
          height: 270,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.25),
                offset: Offset(0, 4),
                blurRadius: 4,
              ),
            ],
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(ImageRes.foodPlaceholder.path),
            ),
            border: Border(bottom: BorderSide(color: Colors.black, width: 1)),
          ),
        )
      : Hero(
          tag: _recipe.imagePath!,
          child: Container(
            height: 270,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.25),
                  offset: Offset(0, 4),
                  blurRadius: 4,
                ),
              ],
              image: DecorationImage(
                fit: BoxFit.cover,
                image: FileImage(File(_recipe.imagePath!)),
              ),
              border: Border(bottom: BorderSide(color: Colors.black, width: 1)),
            ),
          ),
        );
}
