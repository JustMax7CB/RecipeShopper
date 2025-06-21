import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:recipeshopper/resources/resources.dart';

void main() {
  test('icons assets test', () {
    expect(File(Icons.addImageIcon).existsSync(), isTrue);
    expect(File(Icons.addRecipeIcon).existsSync(), isTrue);
    expect(File(Icons.back).existsSync(), isTrue);
    expect(File(Icons.favorites).existsSync(), isTrue);
    expect(File(Icons.home).existsSync(), isTrue);
    expect(File(Icons.pencil).existsSync(), isTrue);
    expect(File(Icons.placeholderImage).existsSync(), isTrue);
    expect(File(Icons.placeholderImageAdd).existsSync(), isTrue);
    expect(File(Icons.profile).existsSync(), isTrue);
    expect(File(Icons.recipeshopper).existsSync(), isTrue);
    expect(File(Icons.search).existsSync(), isTrue);
    expect(File(Icons.settings).existsSync(), isTrue);
    expect(File(Icons.share).existsSync(), isTrue);
    expect(File(Icons.shoppingBasket).existsSync(), isTrue);
  });
}
