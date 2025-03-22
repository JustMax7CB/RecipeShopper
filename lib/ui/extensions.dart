import 'package:flutter/material.dart';

extension TextStroke on TextStyle {
  TextStyle withStroke(double width, Color color) {
    return copyWith(shadows: [
      ...?shadows,
      Shadow(color: color, offset: Offset(width, width)),
      Shadow(color: color, offset: Offset(-width, width)),
      Shadow(color: color, offset: Offset(width, -width)),
      Shadow(color: color, offset: Offset(-width, -width)),
    ]);
  }
}
