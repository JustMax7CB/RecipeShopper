import 'package:flutter/material.dart';
import 'package:recipeshopper/extensions.dart';
import 'package:recipeshopper/ui/colors.dart';
import 'package:recipeshopper/ui/text_styles.dart';

class ButtonSettingsRow extends StatelessWidget {
  const ButtonSettingsRow(this.settingsName,
      {required this.buttonText, required this.onTap, Key? key})
      : super(key: key);

  final String settingsName;
  final String buttonText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
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
            constraints: BoxConstraints(maxHeight: 35),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.25),
                    offset: Offset(1, 2),
                    blurRadius: 2),
              ],
              border: Border.all(color: Colors.black, width: 0.4),
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(
                  colors: [
                    AppColors.saveGradientColor1,
                    AppColors.saveGradientColor2,
                    AppColors.saveGradientColor3
                  ],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  transform: GradientRotation(-0.5)),
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
              onPressed: onTap,
              child: Text(
                context.localized.sync,
                style: titleTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
