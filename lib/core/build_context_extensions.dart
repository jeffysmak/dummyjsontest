import 'package:dummyjsonexample/core/services/alert_service.dart';
import 'package:flutter/material.dart';

import 'di.dart';

extension BuildContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  void showSuccess({required String message}) => (di<AlertService>().success(message));

  void showError({required String message}) => (di<AlertService>().error(message));

  void showInfo({required String message}) => (di<AlertService>().info(message));

  void showWarning({required String message}) => (di<AlertService>().warning(message));
}
