import 'package:get_it/get_it.dart';

abstract class DependencyModule {
  Future<void> registerDependencies(GetIt sl);
}
