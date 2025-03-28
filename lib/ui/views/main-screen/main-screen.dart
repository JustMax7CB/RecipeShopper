import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipeshopper/core/di/locator.dart';
import 'package:recipeshopper/ui/text_styles.dart';
import 'package:recipeshopper/ui/viewmodels/home_viewmodel.dart';
import 'package:recipeshopper/ui/viewmodels/main_viewmodel.dart';
import 'package:recipeshopper/ui/viewmodels/settings_view_model.dart';
import 'package:recipeshopper/ui/views/home-screen/home_screen.dart';
import 'package:recipeshopper/ui/views/main-screen/main_app_bar.dart';
import 'package:recipeshopper/ui/views/main-screen/main_navigation_bar.dart';
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
          child: MainNavigationBar()),
      body: IndexedStack(
        index: viewModel.selectedIndex,
        children: _buildScreens(),
      ),
    );
  }

  List<Widget> _buildScreens() {
    return [
      ChangeNotifierProvider(
        create: (_) => locate<HomeViewModel>(),
        child: HomeScreen(),
      ),
      _buildPlaceholder("Search Screen"),
      _buildPlaceholder("Favorites Screen"),
      ChangeNotifierProvider(
        create: (_) => locate<SettingsViewModel>(),
        child: const SettingsScreen(),
      ),
      _buildPlaceholder("Profile Screen"),
    ];
  }

  Widget _buildPlaceholder(String text) {
    return Container(
      color: Colors.white54,
      child: Center(child: Text(text)),
    );
  }
}
