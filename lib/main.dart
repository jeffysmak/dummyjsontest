import 'package:dummyjsonexample/core/app.dart';
import 'package:dummyjsonexample/core/di.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencyInjection();
  runApp(MyApp());
}
