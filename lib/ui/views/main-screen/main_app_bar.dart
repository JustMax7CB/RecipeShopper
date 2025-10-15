import 'package:flutter/material.dart';
import 'package:recipeshopper/ui/colors.dart';
import 'package:recipeshopper/ui/routes.dart';
import 'package:recipeshopper/ui/widgets/image_resource.dart';
import 'package:recipeshopper/ui/widgets/svg_icon.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({super.key, required this.title});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  final Widget title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: ImageResource(ImageRes.appbarBg),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: AppColors.appBarBorderColor, width: 1),
            boxShadow: [
              BoxShadow(
                color: AppColors.blackQuarterOpacity,
                offset: Offset(1, 1),
                blurRadius: 1,
                spreadRadius: 1,
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: InkWell(
              onTap: () => Navigator.pushNamed(context, Routes.shoppingList.path),
              child: SvgIcon(
                icon: LocalIcons.shoppingCart,
              ),
            ),
          ),
        )
      ],
      flexibleSpace: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black.withAlpha(80),
                offset: Offset(0, 1),
                blurRadius: 4)
          ],
          image: DecorationImage(
            image: ImageResource(ImageRes.woodTexture),
            fit: BoxFit.cover, // Ensure it covers the full space
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: ColorFiltered(
              colorFilter: ColorFilter.srgbToLinearGamma(),
              child: title,
            ),
          ),
        ),
      ),
    );
  }
}
