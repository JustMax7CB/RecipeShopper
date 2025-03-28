import 'package:flutter/material.dart';
import 'package:recipeshopper/resources/resources.dart';

enum ImageRes {
  appbarBg(Images.appbarBg),
  recipeImage(Images.recipeImage),
  fadedWood(Images.fadedWoodBg),
  foodPlaceholder(Images.foodPlaceholder),
  woodTexture(Images.woodTexture);

  const ImageRes(this.path);

  final String path;
}

// ignore: non_constant_identifier_names
AssetImage ImageResource(ImageRes image) => AssetImage(image.path);
