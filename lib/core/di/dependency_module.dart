import 'package:get_it/get_it.dart';

/// Interface que define o contrato para módulos de dependências
/// Cada feature deve implementar esta interface para registrar
/// suas próprias dependências de forma organizada e escalável
abstract class DependencyModule {
  /// Registra todas as dependências do módulo
  /// Este método será chamado durante a inicialização do app
  Future<void> registerDependencies(GetIt sl);
}
