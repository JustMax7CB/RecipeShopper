import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum LocalIcons {
  home("home"),
  search("search"),
  favorites("favorites"),
  settings("settings"),
  profile("profile"),
  shoppingCart("shopping_basket"),
  addRecipe("add_recipe_icon"),
  logo("recipeshopper");

  const LocalIcons(String path) : _path = path;

  final String _path;
  String get path => "lib/assets/icons/$_path.svg";
}

class SvgIcon extends StatelessWidget {
  const SvgIcon(
      {super.key,
      required this.icon,
      this.width,
      this.height,
      this.fit = BoxFit.contain});

  final LocalIcons icon;
  final double? width;
  final double? height;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      icon.path,
      width: width,
      height: height,
      fit: fit,
    );
  }
}
