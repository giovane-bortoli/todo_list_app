/// Classe base para todas as exceções do app
/// Exceptions são usadas na camada de dados (DataSources)
/// Serão convertidas em Failures na camada de Repository
abstract class AppException implements Exception {
  final String message;
  final int? code;

  const AppException({required this.message, this.code});

  @override
  String toString() => 'AppException(message: $message, code: $code)';
}

/// Exceção de cache/armazenamento local
class CacheException extends AppException {
  const CacheException({required super.message, super.code});

  @override
  String toString() => 'CacheException(message: $message, code: $code)';
}

/// Exceção de servidor/API
class ServerException extends AppException {
  const ServerException({required super.message, super.code});

  @override
  String toString() => 'ServerException(message: $message, code: $code)';
}

/// Exceção de rede/conexão
class NetworkException extends AppException {
  const NetworkException({required super.message, super.code});

  @override
  String toString() => 'NetworkException(message: $message, code: $code)';
}

/// Exceção de validação de dados
class ValidationException extends AppException {
  const ValidationException({required super.message, super.code});

  @override
  String toString() => 'ValidationException(message: $message, code: $code)';
}

/// Exceção não encontrado (404)
class NotFoundException extends AppException {
  const NotFoundException({required super.message, super.code});

  @override
  String toString() => 'NotFoundException(message: $message, code: $code)';
}

/// Exceção desconhecida/genérica
class UnknownException extends AppException {
  const UnknownException({required super.message, super.code});

  @override
  String toString() => 'UnknownException(message: $message, code: $code)';
}
