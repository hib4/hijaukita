import 'package:shared_preferences/shared_preferences.dart';

import '../../error/exceptions.dart';


abstract class LocalStorage {
  Future<String> getTokenString(String key);

  Future<void> setTokenString(String key, String token);

  Future<void> removeToken(String key);
}

class LocalStorageImpl implements LocalStorage {
  const LocalStorageImpl({required this.sharedPreferences});

  final SharedPreferences sharedPreferences;

  @override
  Future<String> getTokenString(String key) {
    final token = sharedPreferences.getString(key);
    if (token != null) {
      return Future.value(token);
    } else {
      throw const CacheException();
    }
  }

  @override
  Future<void> setTokenString(String key, String value) {
    return sharedPreferences.setString(key, value);
  }

  @override
  Future<void> removeToken(String key) async {
    final con = await sharedPreferences.remove(key);
    if (!con) {
      throw const CacheException();
    }
  }
}
