import 'package:get_it/get_it.dart';
import 'injection.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  await configureDependencies(); // Calls Injection's generated setup
}

/// A shortcut function to access dependencies easily
T locate<T extends Object>() => locator<T>();