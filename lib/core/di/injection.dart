import 'package:appwrite/appwrite.dart';
import 'injection.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:recipeshopper/environment.dart' as Env;
	
final getIt = GetIt.instance;  
  
@InjectableInit(  
  initializerName: 'init', // default  
  preferRelativeImports: true, // default  
  asExtension: true, // default  
)  
void configureDependencies() {
  getIt.init();


  Client client = Client()
      .setEndpoint("https://cloud.appwrite.io/v1")
      .setProject(Env.EnvVariables.projectId);
  Account account = Account(client);

  getIt.registerLazySingleton(() => Account(client));
}
