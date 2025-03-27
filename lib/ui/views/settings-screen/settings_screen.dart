import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipeshopper/assets/localization/app_locale.dart';
import 'package:recipeshopper/extensions.dart';
import 'package:recipeshopper/locale_provider.dart';
import 'package:recipeshopper/ui/colors.dart';
import 'package:recipeshopper/ui/text_styles.dart';
import 'package:recipeshopper/ui/viewmodels/settings_view_model.dart';
import 'package:recipeshopper/ui/views/settings-screen/button_settings_row.dart';
import 'package:recipeshopper/ui/views/settings-screen/dropdown_settings_row.dart';
import 'package:recipeshopper/ui/views/settings-screen/switch_settings_row.dart';
import 'package:recipeshopper/ui/widgets/image_resource.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SettingsViewModel>();
    final localeProvider = context.watch<LocaleProvider>();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_sharp,
              size: 25,
              color: Colors.white,
              shadows: [
                Shadow(color: Colors.black, offset: Offset(0, 1), blurRadius: 8)
              ],
            )),
        centerTitle: true,
        title: Text(
          context.localized.settings,
          style: titleTextStyle,
        ),
        flexibleSpace: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withAlpha(80),
                    offset: Offset(0, 1),
                    blurRadius: 4)
              ],
              image: DecorationImage(
                fit: BoxFit.cover,
                colorFilter: ColorFilter.linearToSrgbGamma(),
                image: ImageResource(ImageRes.woodTexture),
              )),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: ImageResource(ImageRes.fadedWood),
          ),
        ),
        child: Column(
          spacing: 4,
          children: [
            SwitchSettingsRow(
              context.localized.darkMode,
              value: viewModel.darkModeValue,
              onChanged: viewModel.changeDarkModeValue,
              icons: [Icons.light_mode, Icons.dark_mode],
              activeBgColors: [
                [Colors.amberAccent],
                [Colors.red]
              ],
            ),
            DropdownSettingsRow<SupportedLanguages>(
              context.localized.language,
              value: viewModel.selectedLanguage,
              onChanged: (value) =>
                  viewModel.changeLanguage(value!, localeProvider),
              items: SupportedLanguages.values
                  .map((lang) => DropdownMenuItem(
                        value: lang,
                        child: Text(
                          lang.getLocalizedName(context),
                          style: settingDropdownValueTextStyle,
                        ),
                      ))
                  .toList(),
            ),
            SwitchSettingsRow(
              context.localized.autoSync,
              onChanged: viewModel.changeAutoSyncValue,
              value: viewModel.autoSyncValue,
            ),
            ButtonSettingsRow(
              context.localized.syncData,
              buttonText: context.localized.sync,
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }
}
