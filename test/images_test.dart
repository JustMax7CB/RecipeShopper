import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:recipeshopper/resources/resources.dart';

void main() {
  test('images assets test', () {
    expect(File(Images.appbarBg).existsSync(), isTrue);
    expect(File(Images.recipeImage).existsSync(), isTrue);
  });
}
