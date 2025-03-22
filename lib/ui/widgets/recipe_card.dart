import 'dart:io';

import 'package:flutter/material.dart';
import 'package:recipeshopper/core/models/recipe.dart';
import 'package:recipeshopper/ui/text_styles.dart';

class RecipeCard extends StatefulWidget {
  const RecipeCard(
      {super.key,
      required Recipe recipe,
      this.onClickAction,
      this.onLongPressAction})
      : _recipe = recipe;

  final Recipe _recipe;
  final GestureTapCallback? onClickAction;
  final GestureTapCallback? onLongPressAction;

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.pushNamed(context, "/recipe", arguments: widget._recipe),
      child: Container(
        width: 160,
        height: 145,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 5,
              offset: Offset(0, 2),
            )
          ],
          borderRadius: BorderRadius.circular(12),
          color: Color(0xFFF5F5F5),
          border: Border.all(color: Color.fromRGBO(0, 0, 0, 0.6), width: 0.2),
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
                  Positioned(
                    top: -5,
                    left: -5,
                    child: Checkbox(
                      side: BorderSide(
                          width: 1, color: Colors.black, strokeAlign: -0.5),
                      value: isSelected,
                      onChanged: (value) {
                        setState(() {
                          isSelected = value!;
                        });
                      },
                      fillColor: WidgetStatePropertyAll(Color(0xFFFFFFFF)),
                      checkColor: Color(0xFF000000),
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
            fit: BoxFit.cover,
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
