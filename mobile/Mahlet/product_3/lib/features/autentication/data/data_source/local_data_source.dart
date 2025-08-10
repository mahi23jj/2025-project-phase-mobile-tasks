

abstract class LocalUserDataSource {
  Future<void> saverememberme(String userid);
  Future<String> getrememberme();
  Future<void> savetoken(String token);
  Future<String> gettoken();
}
