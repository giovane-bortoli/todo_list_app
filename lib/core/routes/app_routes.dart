/// Classe central que armazena todas as constantes de rotas do app
/// Organize as rotas por feature para facilitar manutenção
class AppRoutes {
  AppRoutes._();

  // ===== ROTAS PRINCIPAIS =====

  static const String home = '/';
  static const String splash = '/splash';
  static const String example = '/example';

  // ===== ROTAS DA FEATURE TODO =====

  static const String todoEdit = '/todo/edit';
  static const String todoDetails = '/todo/details';

  // ===== ROTAS DA FEATURE AUTH =====
  // static const String login = '/auth/login';
  // static const String register = '/auth/register';
  // static const String forgotPassword = '/auth/forgot-password';

  // ===== ROTAS DA FEATURE PROFILE =====
  // static const String profile = '/profile';
  // static const String profileEdit = '/profile/edit';
  // static const String settings = '/profile/settings';

  /// Retorna todas as rotas do app como lista
  /// Útil para debugging e logs
  static List<String> get allRoutes => [home, splash, todoEdit, todoDetails];
}
