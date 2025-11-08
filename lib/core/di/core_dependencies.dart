import 'package:get_it/get_it.dart';
import 'package:todo_list_app/core/di/dependency_module.dart';

/// Módulo de dependências do Core
/// Registra dependências compartilhadas por todas as features
/// Ex: Network, Storage, Utils, Services globais
class CoreDependenciesModule implements DependencyModule {
  @override
  Future<void> registerDependencies(GetIt sl) async {
    // ===== NETWORK =====

    // HTTP Client (Dio, http, etc)
    // sl.registerLazySingleton<Dio>(() {
    //   final dio = Dio();
    //   dio.options.baseUrl = 'https://api.example.com';
    //   dio.options.connectTimeout = const Duration(seconds: 30);
    //   dio.options.receiveTimeout = const Duration(seconds: 30);
    //   dio.interceptors.add(LogInterceptor(responseBody: true));
    //   return dio;
    // });

    // Network Info (verifica conectividade)
    // sl.registerLazySingleton<NetworkInfo>(
    //   () => NetworkInfoImpl(sl()),
    // );

    // ===== LOCAL STORAGE =====

    // Shared Preferences
    // final sharedPreferences = await SharedPreferences.getInstance();
    // sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

    // Flutter Secure Storage
    // sl.registerLazySingleton<FlutterSecureStorage>(
    //   () => const FlutterSecureStorage(),
    // );

    // Database (Hive, SQLite, etc)
    // sl.registerLazySingleton<Database>(() => DatabaseImpl());

    // ===== UTILS & SERVICES =====

    // Input Validators
    // sl.registerLazySingleton<InputValidator>(() => InputValidator());

    // Date Formatter
    // sl.registerLazySingleton<DateFormatter>(() => DateFormatter());

    // Logger
    // sl.registerLazySingleton<Logger>(() => Logger());

    print('  ✓ Core dependencies registered');
  }
}
