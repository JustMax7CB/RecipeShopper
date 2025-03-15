// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../services/mock/recipe_service_local.dart' as _i597;
import '../services/mock/recipe_service_remote.dart' as _i1026;
import '../services/prod/recipe_service_local.dart' as _i51;
import '../services/prod/recipe_service_remote.dart' as _i187;

const String _mock = 'mock';
const String _prod = 'prod';

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
    gh.factory<_i597.LocalRecipeServiceMock>(
      () => _i597.LocalRecipeServiceMock(),
      registerFor: {_mock},
    );
    gh.factory<_i1026.RemoteRecipeServiceMock>(
      () => _i1026.RemoteRecipeServiceMock(),
      registerFor: {_mock},
    );
    gh.factory<_i51.LocalRecipeService>(
      () => _i51.LocalRecipeService(),
      registerFor: {_prod},
    );
    gh.factory<_i187.RemoteRecipeService>(
      () => _i187.RemoteRecipeService(),
      registerFor: {_prod},
    );
    return this;
  }
}
