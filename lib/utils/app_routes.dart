import 'package:flutter/material.dart';

class AppRoutes {
  static Future<T?> push<T extends Object?>(
    BuildContext context,
    Widget widget,
  ) {
    if (!context.mounted) return Future.value(null);

    return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        ));
  }

  static Future<T?> pushReplacement<T extends Object?>(
    BuildContext context,
    Widget widget,
  ) {
    if (!context.mounted) return Future.value(null);
    return Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        ));
  }

  static void pop<T extends Object?>(BuildContext context, [T? result]) {
    if (context.mounted) {
      return Navigator.pop(context, result);
    }
  }
}
