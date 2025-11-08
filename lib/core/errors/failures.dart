/// Classe base para todos os tipos de falhas/erros do app
/// Segue o padrão de Error Handling da Clean Architecture
abstract class Failure {
  final String message;
  final int? code;

  const Failure({required this.message, this.code});

  @override
  String toString() => 'Failure(message: $message, code: $code)';
}

/// Falha de cache/armazenamento local
class CacheFailure extends Failure {
  const CacheFailure({required super.message, super.code});
}

/// Falha de servidor/API
class ServerFailure extends Failure {
  const ServerFailure({required super.message, super.code});
}

/// Falha de rede/conexão
class NetworkFailure extends Failure {
  const NetworkFailure({required super.message, super.code});
}

/// Falha de validação de dados
class ValidationFailure extends Failure {
  const ValidationFailure({required super.message, super.code});
}

/// Falha não encontrado (404)
class NotFoundFailure extends Failure {
  const NotFoundFailure({required super.message, super.code});
}

/// Falha desconhecida/genérica
class UnknownFailure extends Failure {
  const UnknownFailure({required super.message, super.code});
}
