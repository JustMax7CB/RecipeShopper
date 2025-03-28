import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:recipeshopper/ui/colors.dart';
import 'package:recipeshopper/ui/text_styles.dart';

class SwitchSettingsRow extends StatelessWidget {
  const SwitchSettingsRow(this.settingsName,
      {required this.onChanged,
      required this.value,
      this.icons = const [
        Icon(Icons.check),
        Icon(Icons.disabled_by_default_outlined)
      ],
      this.activeBgColors = const [
        Color(0x661FED1F),
        Color(0x66B81212)
      ],
      super.key});

  final String settingsName;
  final bool value;
  final void Function(bool value) onChanged;
  final List<Icon>? icons;
  final List<Color> activeBgColors;

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
        color: AppColors.recipeImageBgColor.withAlpha(60),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            settingsName,
            style: settingNameTextStyle,
          ),
          AnimatedToggleSwitch<bool>.rolling(
            animationDuration: Duration(milliseconds: 100),
            height: 35,
            iconList: icons,
            current: value,
            styleList: [
              ToggleStyle(backgroundColor: activeBgColors[0]),
              ToggleStyle(backgroundColor: activeBgColors[1]),

            ],
            values: [false, true],
            onChanged: onChanged,
          )
        ],
      ),
    );
  }
}
