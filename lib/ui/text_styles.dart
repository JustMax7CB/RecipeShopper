import 'package:flutter/material.dart';
import 'package:recipeshopper/ui/extenstions.dart';

final _kalamTextStyle = TextStyle(fontFamily: "Kalam");

final TextStyle titleTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 32,
    fontWeight: FontWeight.w600,
    fontFamily: "Kalam",
    shadows: [
      Shadow(
        color: Color(0xFF3D6179),
        blurRadius: 4,
        offset: Offset(1, 2),
      )
    ]).withStroke(0.7, Colors.black);

final recipeNameTextStyle =
    _kalamTextStyle.copyWith(fontSize: 15, fontWeight: FontWeight.w400);
