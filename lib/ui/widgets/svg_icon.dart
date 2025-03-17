import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum LocalIcons {
  home("home"),
  search("search"),
  favorites("favorites"),
  settings("settings"),
  profile("profile"),
  shoppingCart("shopping_basket"),
  addRecipe("add_recipe_icon");

  const LocalIcons(String path) : _path = path;

  final String _path;
  String get path => "lib/assets/icons/$_path.svg";
}

class SvgIcon extends StatelessWidget {
  const SvgIcon({super.key, required this.icon, this.width});

  final LocalIcons icon;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      icon.path,
      width: width,
    );
  }
}
