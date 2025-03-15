import 'package:get_it/get_it.dart';
import 'injection.dart';

final locator = GetIt.instance;

void setupLocator() {
  configureDependencies(); // Calls Injection's generated setup
}

/// A shortcut function to access dependencies easily
T locate<T extends Object>() => locator<T>();