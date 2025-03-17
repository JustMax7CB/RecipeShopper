import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:recipeshopper/ui/widgets/svg_icon.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      actions: [
        Container(
          margin: EdgeInsets.only(right: 10),
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("lib/assets/images/appbar_bg.png"),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Color(0xFF635648), width: 1),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.25),
                offset: Offset(1, 1),
                blurRadius: 1,
                spreadRadius: 1,
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: SvgIcon(
              icon: LocalIcons.shoppingCart,
            ),
          ),
        )
      ],
      flexibleSpace: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/assets/images/appbar_bg.png"),
            fit: BoxFit.cover, // Ensure it covers the full space
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: SvgIcon(
              icon: LocalIcons.logo,
              height: 45,
              width: 147,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
