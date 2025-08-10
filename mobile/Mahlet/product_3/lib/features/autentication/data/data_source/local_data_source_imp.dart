import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/Error/exception.dart';
import 'local_data_source.dart';

class LocaluserDataSourceImp implements LocalUserDataSource {
  final SharedPreferences sharedpreferences;

  LocaluserDataSourceImp(this.sharedpreferences);

  static const String _cacheKey = 'rememberme';

  @override
  Future<void> saverememberme(String userid) async {
    await sharedpreferences.setString(_cacheKey, userid);
  }

  @override
  Future<String> getrememberme() async {
    final result = sharedpreferences.getString(_cacheKey);

    if (result == null) {
      throw CacheException();
    } else {
      return result;
    }
  }

  @override
  Future<void> savetoken(String token) async {
    // TODO: implement savetoken
    await sharedpreferences.setString('token', token);
  }

  @override
  Future<String> gettoken() async {
    // TODO: implement gettoken
    final result = await sharedpreferences.getString('token');

    if (result == null) {
      throw CacheException();
    } else {
      return result;
    }
  }
}
