class AppRoutes {
  AppRoutes._();

  // ===== ROTAS PRINCIPAIS =====

  static const String home = '/';
  static const String splash = '/splash';
  static const String example = '/example';

  // ===== ROTAS DA FEATURE TODO =====

  static const String todoEdit = '/todo/edit';
  static const String todoDetails = '/todo/details';

  static List<String> get allRoutes => [home, splash, todoEdit, todoDetails];
}
