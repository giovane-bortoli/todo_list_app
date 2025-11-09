import 'package:flutter/material.dart';
import 'package:todo_list_app/core/routes/app_routes.dart';

class Navigation {
  Navigation._();

  static Future<T?> push<T>(BuildContext context, String routeName, {Object? arguments}) {
    return Navigator.of(context).pushNamed<T>(routeName, arguments: arguments);
  }

  static Future<T?> pushReplacement<T, TO>(BuildContext context, String routeName, {Object? arguments, TO? result}) {
    return Navigator.of(context).pushReplacementNamed<T, TO>(routeName, arguments: arguments, result: result);
  }

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

  static void pop<T>(BuildContext context, [T? result]) {
    Navigator.of(context).pop(result);
  }

  static bool canPop(BuildContext context) {
    return Navigator.of(context).canPop();
  }

  static Future<void> toHome(BuildContext context, {bool clearStack = false}) {
    if (clearStack) {
      return pushAndRemoveUntil(context, AppRoutes.home);
    }
    return push(context, AppRoutes.home);
  }

  static Future<void> toTodoEdit(BuildContext context, String taskId) {
    return push(context, '/todo/edit/$taskId');
  }

  static Future<void> toTodoDetails(BuildContext context, String taskId) {
    return push(context, '/todo/details/$taskId');
  }
}

extension NavigationExtension on BuildContext {
  Future<T?> pushNamed<T>(String routeName, {Object? arguments}) {
    return Navigation.push<T>(this, routeName, arguments: arguments);
  }

  Future<T?> pushReplacementNamed<T, TO>(String routeName, {Object? arguments, TO? result}) {
    return Navigation.pushReplacement<T, TO>(this, routeName, arguments: arguments, result: result);
  }

  void pop<T>([T? result]) {
    Navigation.pop<T>(this, result);
  }

  bool get canPop => Navigation.canPop(this);

  Future<void> toHome({bool clearStack = false}) => Navigation.toHome(this, clearStack: clearStack);
  Future<void> toTodoEdit(String taskId) => Navigation.toTodoEdit(this, taskId);
  Future<void> toTodoDetails(String taskId) => Navigation.toTodoDetails(this, taskId);
}
