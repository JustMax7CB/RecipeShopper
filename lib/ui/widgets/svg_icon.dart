import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipeshopper/resources/resources.dart' as res;

enum LocalIcons {
  home(res.Icons.home),
  search(res.Icons.search),
  favorites(res.Icons.favorites),
  settings(res.Icons.settings),
  profile(res.Icons.profile),
  shoppingCart(res.Icons.shoppingBasket),
  addRecipe(res.Icons.addRecipeIcon),
  logo(res.Icons.splashLogo),
  placeholderImage(res.Icons.placeholderImage),
  share(res.Icons.share),
  pencil(res.Icons.pencil),
  appbarLogo(res.Icons.recipeshopper);

  const LocalIcons(this.path);

  final String path;
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
