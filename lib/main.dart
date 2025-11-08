import 'package:flutter/material.dart';
import 'package:todo_list_app/app_widget.dart';
import 'package:todo_list_app/core/di/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ServiceLocator.init();

  runApp(const MyApp());
}
