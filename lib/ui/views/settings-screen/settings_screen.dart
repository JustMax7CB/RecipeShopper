import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipeshopper/assets/localization/app_locale.dart';
import 'package:recipeshopper/extensions.dart';
import 'package:recipeshopper/locale_provider.dart';
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
    return Container(
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
            icons: [Icon(Icons.light_mode), Icon(Icons.dark_mode)],
            activeBgColors: [Colors.amberAccent, Colors.black26],
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
            onTap: viewModel.syncData,
          ),
          ButtonSettingsRow(
            context.localized.clearData,
            buttonText: context.localized.clear,
            onTap: () async => await viewModel.clearData(),
          ),
        ],
      ),
    );
  }
}
