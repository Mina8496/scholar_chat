import 'package:flutter/material.dart';

class AppSnackBar {
  AppSnackBar._();

  static void _show(BuildContext context, String message, Color color,
      IconData icon) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: color,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Row(
            children: [
              Icon(icon, color: Colors.white),
              const SizedBox(width: 10),
              Expanded(child: Text(message)),
            ],
          ),
        ),
      );
  }

  static void success(BuildContext context, String message) =>
      _show(context, message, Colors.green.shade600, Icons.check_circle);

  static void error(BuildContext context, String message) =>
      _show(context, message, Colors.red.shade600, Icons.error);

  static void info(BuildContext context, String message) =>
      _show(context, message, Colors.blueGrey.shade700, Icons.info);
}
