import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum SharedPrefKey implements Comparable<SharedPrefKey> {
  darkMode("darkModeEnabled"),
  language("language"),
  autoSync("autoSync"),
  recipeSorting("recipeSorting");

  final String key;

  const SharedPrefKey(this.key);

  @override
  int compareTo(SharedPrefKey other) {
    return key.compareTo(other.key);
  }
}

@lazySingleton
class SharedPrefsService {
  final SharedPreferences _sharedPreferences;

  SharedPrefsService(this._sharedPreferences);

  Future<void> setKey<T>(String key, T value) async {
    switch (value) {
      case int v:
        await _sharedPreferences.setInt(key, v);
        break;
      case double v:
        await _sharedPreferences.setDouble(key, v);
        break;
      case bool v:
        await _sharedPreferences.setBool(key, v);
        break;
      case String v:
        await _sharedPreferences.setString(key, v);
        break;
      case List<String> v:
        await _sharedPreferences.setStringList(key, v);
        break;
      default:
        throw ArgumentError("Unsupported value type: ${value.runtimeType}");
    }
  }

  Future<int> getInt(String key, {int def = 0}) async =>
      _sharedPreferences.getInt(key) ?? def;

  Future<double> getDouble(String key, {double def = 0.0}) async =>
      _sharedPreferences.getDouble(key) ?? def;

  Future<String> getString(String key, {String def = ""}) async =>
      _sharedPreferences.getString(key) ?? def;

  Future<List<String>> getStringList(String key,
          {List<String> def = const []}) async =>
      _sharedPreferences.getStringList(key) ?? def;

  Future<bool> getBool(String key, {bool def = false}) async =>
      _sharedPreferences.getBool(key) ?? def;

  Future<Set<String>> getKeys() async => _sharedPreferences.getKeys();
}
