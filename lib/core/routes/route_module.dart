import 'package:flutter/material.dart';

/// Interface que define o contrato para módulos de rotas
/// Cada feature deve implementar esta interface para registrar
/// suas próprias rotas de forma organizada e escalável
abstract class RouteModule {
  /// Retorna o mapa de rotas da feature
  /// Key: nome da rota (ex: '/todo/list')
  /// Value: builder da página
  Map<String, WidgetBuilder> getRoutes();

  /// Método opcional para gerar rotas dinâmicas
  /// Útil para rotas com parâmetros (ex: '/todo/details/:id')
  Route<dynamic>? generateRoute(RouteSettings settings) => null;
}
