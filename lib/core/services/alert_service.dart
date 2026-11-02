import 'package:dummyjsonexample/core/theme/app_colors.dart';
import 'package:dummyjsonexample/core/theme/app_radius.dart';
import 'package:dummyjsonexample/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class AlertService {
  AlertService({GlobalKey<ScaffoldMessengerState>? messengerKey, GlobalKey<NavigatorState>? navigatorKey})
    : _messengerKey = messengerKey ?? GlobalKey<ScaffoldMessengerState>(),
      _navigatorKey = navigatorKey ?? GlobalKey<NavigatorState>();

  final GlobalKey<ScaffoldMessengerState> _messengerKey;
  final GlobalKey<NavigatorState> _navigatorKey;

  GlobalKey<ScaffoldMessengerState> get messengerKey => _messengerKey;

  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  void success(String message) {
    _showSnackBar(
      message: message,
      backgroundColor: AppColors.success,
      textColor: AppColors.onSuccess,
      icon: Icons.check_circle_outline_rounded,
    );
  }

  void error(String message) {
    _showSnackBar(message: message, backgroundColor: AppColors.error, textColor: AppColors.onError, icon: Icons.error_outline_rounded);
  }

  void info(String message) {
    _showSnackBar(message: message, backgroundColor: AppColors.info, textColor: AppColors.onInfo, icon: Icons.info_outline_rounded);
  }

  void warning(String message) {
    _showSnackBar(
      message: message,
      backgroundColor: AppColors.warning,
      textColor: AppColors.onWarning,
      icon: Icons.warning_amber_rounded,
    );
  }

  void _showSnackBar({required String message, required Color backgroundColor, required Color textColor, required IconData icon}) {
    final state = _messengerKey.currentState;
    if (state == null) return;

    state.hideCurrentSnackBar();
    state.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 3),
        elevation: 4,
        margin: AppSpacing.edgeInsetsMd,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.borderMd),
        content: Row(
          children: [
            Icon(icon, color: textColor, size: 20),
            AppSpacing.gapSm,
            Expanded(
              child: Text(
                message,
                style: TextStyle(color: textColor, fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
