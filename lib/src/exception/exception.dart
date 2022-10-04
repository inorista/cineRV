class ApiException implements Exception {
  const ApiException({this.code, required this.message});
  final String message;
  final int? code;

  factory ApiException.fromCode(int codes) {
    switch (codes) {
      case 400:
        return const ApiException(
            code: 400, message: "The request was unacceptable, often due to missing a required parameter");
      case 401:
        return const ApiException(code: 401, message: "Invalid Access Token");
      case 403:
        return const ApiException(code: 403, message: "Missing permissions to perform request");
      case 404:
        return const ApiException(code: 404, message: "The requested resource doesn't exist");
      case 500:
        return const ApiException(code: 500, message: "Something went wrong on our end");
      case 503:
        return const ApiException(code: 503, message: "Something went wrong on our end");
      default:
        return const ApiException(message: "Error");
    }
  }

  @override
  String toString() => 'ApiException(code: $code ,message: $message)';
}
