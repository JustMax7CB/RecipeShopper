import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:recipeshopper/resources/resources.dart';

void main() {
  test('images assets test', () {
    expect(File(Images.appbarBg).existsSync(), isTrue);
    expect(File(Images.cookBook).existsSync(), isTrue);
    expect(File(Images.fadedWoodBg).existsSync(), isTrue);
    expect(File(Images.foodPlaceholder).existsSync(), isTrue);
    expect(File(Images.wood_texture).existsSync(), isTrue);
    expect(File(Images.recipeImage).existsSync(), isTrue);
  });
}
