import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipeshopper/extensions.dart';
import 'package:recipeshopper/ui/colors.dart';
import 'package:recipeshopper/ui/text_styles.dart';
import 'package:recipeshopper/ui/viewmodels/settings_view_model.dart';

class DropdownSettingsRow<T> extends StatelessWidget {
  const DropdownSettingsRow(this.settingsName,
      {required this.value,
      required this.items,
      required this.onChanged,
      super.key});

  final String settingsName;
  final T value;
  final void Function(T? value) onChanged;
  final List<DropdownMenuItem<T>> items;

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SettingsViewModel>();
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 12),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.symmetric(
          horizontal:
              BorderSide(color: AppColors.settingsTileBorderColor, width: 1),
        ),
        color: AppColors.recipeImageBgColor.withAlpha(127),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            settingsName,
            style: settingNameTextStyle,
          ),
          Container(
            height: 45,
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(width: 1, color: Colors.black),
              color: AppColors.textFieldFillColor,
            ),
            child: DropdownButton<T>(
                padding: EdgeInsets.symmetric(horizontal: 30),
                value: value,
                hint: Text(
                  context.localized.language,
                  style: settingDropdownHintTextStyle,
                ),
                underline: SizedBox(),
                borderRadius: BorderRadius.circular(5),
                dropdownColor: AppColors.textFieldFillColor,
                items: items,
                onChanged: onChanged),
          )
        ],
      ),
    );
  }
}
