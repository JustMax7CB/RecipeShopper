import 'package:flutter/material.dart';
import 'package:recipeshopper/ui/colors.dart';
import 'package:recipeshopper/ui/text_styles.dart';
import 'package:toggle_switch/toggle_switch.dart';

class SwitchSettingsRow extends StatelessWidget {
  const SwitchSettingsRow(this.settingsName,
      {required this.onChanged,
      required this.value,
      this.icons = const [Icons.check, Icons.disabled_by_default_outlined],
      this.activeBgColors = const [
        [Colors.green],
        [Colors.red]
      ],
      super.key});

  final String settingsName;
  final bool value;
  final void Function(bool value) onChanged;
  final List<IconData>? icons;
  final List<List<Color>> activeBgColors;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      margin: EdgeInsets.only(top: 22),
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
          ToggleSwitch(
            initialLabelIndex: value ? 1 : 0,
            minWidth: 50,
            minHeight: 30,
            borderColor: [Colors.black],
            borderWidth: 1,
            inactiveBgColor: AppColors.textFieldHintColor.withAlpha(150),
            activeFgColor: Colors.black,
            cornerRadius: 8.0,
            totalSwitches: 2,
            icons: icons,
            iconSize: 20.0,
            activeBgColors: activeBgColors,
            animate: true,
            curve: Curves.easeIn,
            states: [true, false],
            onToggle: (index) {
              onChanged(index == 1);
            },
          )
        ],
      ),
    );
  }
}
