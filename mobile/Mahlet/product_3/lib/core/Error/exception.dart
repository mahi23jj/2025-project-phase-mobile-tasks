class ServerException implements Exception {}


class NetworkException implements Exception {
  String? message;
  NetworkException({ this.message});
}

class CacheException implements Exception {
  String? message;
  CacheException({ this.message});
}

