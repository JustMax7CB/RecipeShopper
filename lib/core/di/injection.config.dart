// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../ui/viewmodels/add_recipe_viewmodel.dart' as _i212;
import '../../ui/viewmodels/home_viewmodel.dart' as _i210;
import '../repositories/recipe_repository.dart' as _i653;
import '../services/mock/recipe_service_local.dart' as _i597;
import '../services/mock/recipe_service_remote.dart' as _i1026;
import '../services/prod/recipe_service_local.dart' as _i51;
import '../services/prod/recipe_service_remote.dart' as _i187;

const String _mock = 'mock';

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i51.LocalRecipeService>(() => _i51.LocalRecipeService());
    gh.singleton<_i187.RemoteRecipeService>(() => _i187.RemoteRecipeService());
    gh.singleton<_i597.LocalRecipeServiceMock>(
      () => _i597.LocalRecipeServiceMock(),
      registerFor: {_mock},
    );
    gh.singleton<_i1026.RemoteRecipeServiceMock>(
      () => _i1026.RemoteRecipeServiceMock(),
      registerFor: {_mock},
    );
    gh.lazySingleton<_i653.RecipeRepository>(() => _i653.RecipeRepository(
          gh<_i51.LocalRecipeService>(),
          gh<_i187.RemoteRecipeService>(),
        ));
    gh.factory<_i210.HomeViewModel>(
        () => _i210.HomeViewModel(gh<_i653.RecipeRepository>()));
    gh.factory<_i212.AddRecipeViewModel>(
        () => _i212.AddRecipeViewModel(gh<_i653.RecipeRepository>()));
    return this;
  }
}
