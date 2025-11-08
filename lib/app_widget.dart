import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_list_app/core/routes/app_routes.dart';
import 'package:todo_list_app/core/routes/route_manager.dart';
import 'package:todo_list_app/shared/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),

      minTextAdapt: true,

      splitScreenMode: true,

      builder: (context, child) {
        return MaterialApp(
          title: 'To-Do List',
          debugShowCheckedModeBanner: false,

          theme: AppTheme.lightTheme,

          darkTheme: AppTheme.darkTheme,

          themeMode: ThemeMode.system,

          // ===== SISTEMA DE ROTAS =====

          // Rota inicial do app (usar '/' evita mostrar botão de voltar)
          initialRoute: AppRoutes.home, // AppRoutes.home = '/'
          // Rotas nomeadas (rotas estáticas de todas as features)
          routes: RouteManager.getRoutes(),

          // Gerador de rotas dinâmicas (rotas com parâmetros)
          onGenerateRoute: RouteManager.onGenerateRoute,

          // Fallback para rotas não encontradas
          onUnknownRoute: RouteManager.onUnknownRoute,
        );
      },
    );
  }
}
