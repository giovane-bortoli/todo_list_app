abstract class AppException implements Exception {
  final String message;
  final int? code;

  const AppException({required this.message, this.code});

  @override
  String toString() => 'AppException(message: $message, code: $code)';
}

class CacheException extends AppException {
  const CacheException({required super.message, super.code});

  @override
  String toString() => 'CacheException(message: $message, code: $code)';
}

class ServerException extends AppException {
  const ServerException({required super.message, super.code});

  @override
  String toString() => 'ServerException(message: $message, code: $code)';
}

class NetworkException extends AppException {
  const NetworkException({required super.message, super.code});

  @override
  String toString() => 'NetworkException(message: $message, code: $code)';
}

class ValidationException extends AppException {
  const ValidationException({required super.message, super.code});

  @override
  String toString() => 'ValidationException(message: $message, code: $code)';
}

class NotFoundException extends AppException {
  const NotFoundException({required super.message, super.code});

  @override
  String toString() => 'NotFoundException(message: $message, code: $code)';
}

class UnknownException extends AppException {
  const UnknownException({required super.message, super.code});

  @override
  String toString() => 'UnknownException(message: $message, code: $code)';
}
