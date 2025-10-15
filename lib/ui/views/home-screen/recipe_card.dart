import 'dart:io';

import 'package:flutter/material.dart';
import 'package:recipeshopper/core/models/recipe.dart';
import 'package:recipeshopper/resources/resources.dart' as res;
import 'package:recipeshopper/ui/colors.dart';
import 'package:recipeshopper/ui/routes.dart';
import 'package:recipeshopper/ui/text_styles.dart';

class RecipeCard extends StatelessWidget {
  RecipeCard(
      {super.key,
      required Recipe recipe,
      this.onClickAction,
      required this.deleteAction,
      this.showDelete = false,
      this.showSelection = false,
      required this.selectAction,
      this.isSelected = false})
      : _recipe = recipe;

  final Recipe _recipe;
  final GestureTapCallback? onClickAction;
  final Function(Recipe recipe) deleteAction;
  final bool showDelete;
  final bool showSelection;
  final Function(Recipe recipe) selectAction;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.pushNamed(context, Routes.recipe.path, arguments: _recipe),
      child: Container(
        width: 160,
        height: 145,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(80),
              blurRadius: 5,
              offset: Offset(0, 2),
            )
          ],
          borderRadius: BorderRadius.circular(12),
          color: AppColors.recipeCardBgColor,
          border: isSelected
              ? Border.all(color: AppColors.recipeCardBorderColor, width: 2)
              : Border.all(color: AppColors.recipeCardBorderColor, width: 0.2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image with rounded corners
            Flexible(
              flex: 5,
              child: Stack(
                children: [
                  imageWidget(),
                  // Small white square at top-left
                  Visibility(
                    visible: showSelection,
                    child: Positioned(
                      top: -5,
                      left: -5,
                      child: Checkbox(
                        side: BorderSide(
                            width: 1, color: Colors.black, strokeAlign: -0.5),
                        value: isSelected,
                        onChanged: (_) => selectAction(_recipe),
                        fillColor: WidgetStatePropertyAll(Colors.white),
                        checkColor: Colors.black,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: showDelete,
                    child: Positioned(
                      top: -5,
                      right: -5,
                      child: IconButton(
                          onPressed: () => deleteAction(_recipe),
                          icon: Icon(
                            Icons.cancel,
                            color: Colors.red[400],
                            shadows: [
                              Shadow(
                                  color: Colors.black,
                                  offset: Offset(0, 1),
                                  blurRadius: 4)
                            ],
                          )),
                    ),
                  ),
                ],
              ),
            ),
            // Bottom text section
            Flexible(
              flex: 2,
              child: Center(
                child: Text(
                  _recipe.name,
                  style: recipeNameTextStyle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget imageWidget() => _recipe.isPlaceholder
      ? ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
          child: Image.asset(
            res.Images.foodPlaceholder,
            width: 160,
            height: 145,
            fit: BoxFit.fitHeight,
          ),
        )
      : Hero(
          tag: _recipe.localImagePath!,
          child: ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.file(
              errorBuilder: (_, __, ___) => Image.asset(
                res.Images.foodPlaceholder,
                width: 160,
                height: 145,
                fit: BoxFit.fitHeight,
              ),
              File(_recipe.localImagePath!),
              width: 160,
              height: 145,
              fit: BoxFit.cover,
            ),
          ),
        );
}
