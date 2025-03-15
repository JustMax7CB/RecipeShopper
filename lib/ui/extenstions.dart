import 'package:flutter/material.dart';

extension TextStroke on TextStyle {
  TextStyle withStroke(double width, Color color) {
    return TextStyle(
        fontWeight: fontWeight,
        fontSize: fontSize,
        fontFamily: fontFamily,
        color: this.color,
        decorationThickness: decorationThickness,
        decoration: decoration,
        fontStyle: fontStyle,
        backgroundColor: backgroundColor,
        background: background,
        debugLabel: debugLabel,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        fontFamilyFallback: fontFamilyFallback,
        fontFeatures: fontFeatures,
        fontVariations: fontVariations,
        foreground: foreground,
        height: height,
        inherit: inherit,
        leadingDistribution: leadingDistribution,
        letterSpacing: letterSpacing,
        overflow: overflow,
        locale: locale,
        textBaseline: textBaseline,
        wordSpacing: wordSpacing,
        shadows: [
          ...?shadows,
          Shadow(color: color, offset: Offset(width, width)),
          Shadow(color: color, offset: Offset(-width, width)),
          Shadow(color: color, offset: Offset(width, -width)),
          Shadow(color: color, offset: Offset(-width, -width)),
        ]);
  }
}
