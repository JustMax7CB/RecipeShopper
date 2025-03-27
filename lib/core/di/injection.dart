import 'package:appwrite/appwrite.dart';
import 'injection.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:recipeshopper/environment.dart' as Env;
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
Future<void> configureDependencies() async {
  Client client = Client()
      .setEndpoint("https://cloud.appwrite.io/v1")
      .setProject(Env.EnvVariables.projectId);
  final prefs = await SharedPreferences.getInstance();

  getIt.registerLazySingleton<Client>(() => client);
  getIt.registerLazySingleton<Account>(() => Account(client));

  getIt.registerSingleton<SharedPreferences>(prefs);

  getIt.init();
}

