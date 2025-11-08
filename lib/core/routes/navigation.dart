import 'package:flutter/material.dart';
import 'package:todo_list_app/core/routes/app_routes.dart';

/// Helper class para navegação type-safe
/// Fornece métodos tipados para navegar entre telas
class Navigation {
  Navigation._();

  // ===== NAVEGAÇÃO BÁSICA =====

  /// Navega para uma rota
  static Future<T?> push<T>(BuildContext context, String routeName, {Object? arguments}) {
    return Navigator.of(context).pushNamed<T>(routeName, arguments: arguments);
  }

  /// Navega substituindo a rota atual
  static Future<T?> pushReplacement<T, TO>(BuildContext context, String routeName, {Object? arguments, TO? result}) {
    return Navigator.of(context).pushReplacementNamed<T, TO>(routeName, arguments: arguments, result: result);
  }

  /// Navega removendo todas as rotas anteriores
  static Future<T?> pushAndRemoveUntil<T>(
    BuildContext context,
    String routeName, {
    Object? arguments,
    bool Function(Route<dynamic>)? predicate,
  }) {
    return Navigator.of(
      context,
    ).pushNamedAndRemoveUntil<T>(routeName, predicate ?? (route) => false, arguments: arguments);
  }

  /// Volta para a tela anterior
  static void pop<T>(BuildContext context, [T? result]) {
    Navigator.of(context).pop(result);
  }

  /// Verifica se pode voltar
  static bool canPop(BuildContext context) {
    return Navigator.of(context).canPop();
  }

  // ===== NAVEGAÇÃO PARA TELAS ESPECÍFICAS =====

  /// Navega para a home
  static Future<void> toHome(BuildContext context, {bool clearStack = false}) {
    if (clearStack) {
      return pushAndRemoveUntil(context, AppRoutes.home);
    }
    return push(context, AppRoutes.home);
  }

  // ===== TODO FEATURE =====

  /// Navega para editar tarefa
  /// [taskId] - ID da tarefa a ser editada
  static Future<void> toTodoEdit(BuildContext context, String taskId) {
    return push(context, '/todo/edit/$taskId');
  }

  /// Navega para detalhes da tarefa
  /// [taskId] - ID da tarefa
  static Future<void> toTodoDetails(BuildContext context, String taskId) {
    return push(context, '/todo/details/$taskId');
  }

  // ===== AUTH FEATURE (EXEMPLO) =====

  // static Future<void> toLogin(BuildContext context) {
  //   return push(context, AppRoutes.login);
  // }

  // static Future<void> toRegister(BuildContext context) {
  //   return push(context, AppRoutes.register);
  // }

  // ===== PROFILE FEATURE (EXEMPLO) =====

  // static Future<void> toProfile(BuildContext context) {
  //   return push(context, AppRoutes.profile);
  // }

  // static Future<void> toSettings(BuildContext context) {
  //   return push(context, AppRoutes.settings);
  // }
}

/// Extension para facilitar navegação diretamente do BuildContext
extension NavigationExtension on BuildContext {
  /// Navega para uma rota
  Future<T?> pushNamed<T>(String routeName, {Object? arguments}) {
    return Navigation.push<T>(this, routeName, arguments: arguments);
  }

  /// Navega substituindo a rota atual
  Future<T?> pushReplacementNamed<T, TO>(String routeName, {Object? arguments, TO? result}) {
    return Navigation.pushReplacement<T, TO>(this, routeName, arguments: arguments, result: result);
  }

  /// Volta para a tela anterior
  void pop<T>([T? result]) {
    Navigation.pop<T>(this, result);
  }

  /// Verifica se pode voltar
  bool get canPop => Navigation.canPop(this);

  // Atalhos para navegação específica
  Future<void> toHome({bool clearStack = false}) => Navigation.toHome(this, clearStack: clearStack);
  Future<void> toTodoEdit(String taskId) => Navigation.toTodoEdit(this, taskId);
  Future<void> toTodoDetails(String taskId) => Navigation.toTodoDetails(this, taskId);
}
