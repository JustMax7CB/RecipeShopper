import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipeshopper/extensions.dart';
import 'package:recipeshopper/ui/colors.dart';
import 'package:recipeshopper/ui/viewmodels/main_viewmodel.dart';
import 'package:recipeshopper/ui/widgets/svg_icon.dart';

class MainNavigationBar extends StatelessWidget {
  const MainNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MainViewModel>();
    return NavigationBar(
        animationDuration: Duration(milliseconds: 400),
        indicatorColor: AppColors.bottomNavbarSelectedBgColor,
        backgroundColor: Colors.transparent,
        indicatorShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        onDestinationSelected: viewModel.changeToIndex,
        selectedIndex: viewModel.selectedIndex,
        destinations: [
          NavigationDestination(
            icon: SvgIcon(
              icon: LocalIcons.home,
              width: 20,
            ),
            label: context.localized.home,
          ),
          NavigationDestination(
            icon: SvgIcon(
              icon: LocalIcons.search,
              width: 20,
            ),
            label: context.localized.search,
            enabled: false,
          ),
          NavigationDestination(
            icon: SvgIcon(
              icon: LocalIcons.favorites,
              width: 20,
            ),
            label: context.localized.favorites,
            enabled: false,
          ),
          NavigationDestination(
            icon: SvgIcon(
              icon: LocalIcons.settings,
              width: 20,
            ),
            label: context.localized.settings,
          ),
          NavigationDestination(
            icon: SvgIcon(
              icon: LocalIcons.profile,
              width: 20,
            ),
            label: context.localized.profile,
            enabled: false,
          ),
        ]);
  }
}
