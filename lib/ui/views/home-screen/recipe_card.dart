import 'dart:io';

import 'package:flutter/material.dart';
import 'package:recipeshopper/core/models/recipe.dart';
import 'package:recipeshopper/ui/colors.dart';
import 'package:recipeshopper/ui/routes.dart';
import 'package:recipeshopper/ui/text_styles.dart';

class RecipeCard extends StatefulWidget {
  RecipeCard({
    super.key,
    required Recipe recipe,
    this.onClickAction,
    required this.deleteAction,
    this.showDelete = false,
    this.showSelection = false,
  }) : _recipe = recipe;

  final Recipe _recipe;
  final GestureTapCallback? onClickAction;
  final Function(Recipe recipe) deleteAction;
  final bool showDelete;
  final bool showSelection;
  bool isSelected = false;

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, Routes.recipe.path,
          arguments: widget._recipe),
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
          border:
              Border.all(color: AppColors.recipeCardBorderColor, width: 0.2),
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
                    visible: widget.showSelection,
                    child: Positioned(
                      top: -5,
                      left: -5,
                      child: Checkbox(
                        side: BorderSide(
                            width: 1, color: Colors.black, strokeAlign: -0.5),
                        value: widget.isSelected,
                        onChanged: (value) {
                          setState(() {
                            widget.isSelected = value!;
                          });
                        },
                        fillColor: WidgetStatePropertyAll(Colors.white),
                        checkColor: Colors.black,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: widget.showDelete,
                    child: Positioned(
                      top: -5,
                      right: -5,
                      child: IconButton(
                          onPressed: () => widget.deleteAction(widget._recipe),
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
                  widget._recipe.name,
                  style: recipeNameTextStyle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget imageWidget() => widget._recipe.isPlaceholder
      ? ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
          child: Image.asset(
            widget._recipe.imagePath!,
            width: 160,
            height: 145,
            fit: BoxFit.fitHeight,
          ),
        )
      : Hero(
          tag: widget._recipe.imagePath!,
          child: ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.file(
              File(widget._recipe.imagePath!),
              width: 160,
              height: 145,
              fit: BoxFit.cover,
            ),
          ),
        );
}
