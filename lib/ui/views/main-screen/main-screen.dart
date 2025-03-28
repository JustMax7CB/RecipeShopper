import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipeshopper/core/di/locator.dart';
import 'package:recipeshopper/extensions.dart';
import 'package:recipeshopper/ui/colors.dart';
import 'package:recipeshopper/ui/text_styles.dart';
import 'package:recipeshopper/ui/viewmodels/home_viewmodel.dart';
import 'package:recipeshopper/ui/viewmodels/main_viewmodel.dart';
import 'package:recipeshopper/ui/viewmodels/settings_view_model.dart';
import 'package:recipeshopper/ui/views/home-screen/home_screen.dart';
import 'package:recipeshopper/ui/views/main-screen/main_app_bar.dart';
import 'package:recipeshopper/ui/views/settings-screen/settings_screen.dart';
import 'package:recipeshopper/ui/widgets/image_resource.dart';
import 'package:recipeshopper/ui/widgets/svg_icon.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MainViewModel>();
    return Scaffold(
      appBar: MainAppBar(
        title: viewModel.title == null
            ? SvgIcon(
                icon: LocalIcons.appbarLogo,
                height: 35,
                fit: BoxFit.cover,
              )
            : Text(
                viewModel.title!,
                style: titleTextStyle,
              ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ImageResource(ImageRes.appbarBg),
            fit: BoxFit.fill,
          ),
        ),
        child: NavigationBar(
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
            ]),
      ),
      body: IndexedStack(
        index: viewModel.selectedIndex,
        children: [
          ChangeNotifierProvider(
              create: (_) => locate<HomeViewModel>(), child: HomeScreen()),
          Container(
            color: Colors.white54,
            child: Center(
              child: Text("Search Screen"),
            ),
          ),
          Container(
            color: Colors.white54,
            child: Center(
              child: Text("Favorites Screen"),
            ),
          ),
          ChangeNotifierProvider(
              create: (context) => locate<SettingsViewModel>(),
              child: SettingsScreen()),
          Container(
            color: Colors.white54,
            child: Center(
              child: Text("Profile Screen"),
            ),
          ),
        ],
      ),
    );
  }
}
