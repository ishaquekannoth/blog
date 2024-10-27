class ServerException implements Exception {
  final String message;

  ServerException({this.message = "Some Exception occured"});
}
