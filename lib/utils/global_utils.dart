import 'package:reaya_shared_code/init/runt_time_variables.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

enum SnackBarType {
  info,
  error,
  success,
}

class GlobalUtils {
  static void showSnackBar({
    required BuildContext context,
    required String message,
    Color? backgroundColor,
    Color? textColor,
    SnackBarType? snackBarType,
    bool aboveBottomNavBar = false,
    EdgeInsets? margin,
    VoidCallback? onActionTapped,
    String? actionString,
  }) {
    try {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: aboveBottomNavBar ? SnackBarBehavior.floating : null,
          content: Text(
            message,
          ),
          backgroundColor: backgroundColor ??
              ((snackBarType ?? SnackBarType.info) == SnackBarType.success
                  ? Colors.green
                  : (snackBarType ?? SnackBarType.info) == SnackBarType.error
                      ? Colors.red
                      : null),
          margin: margin,
          action: SnackBarAction(
            label: actionString ?? 'تم',
            textColor: textColor ??
                ((snackBarType ?? SnackBarType.info) == SnackBarType.error ||
                        (snackBarType ?? SnackBarType.info) ==
                            SnackBarType.success ||
                        (snackBarType ?? SnackBarType.info) == SnackBarType.info
                    ? Colors.white
                    : null),
            onPressed: onActionTapped ?? () {},
          ),
        ),
      );
    } catch (e) {
      if (kDebugMode) {}
      //
    }
  }

  static void fastSnackBar({
    required String msg,
    SnackBarType? snackBarType,
    GlobalKey<NavigatorState>? navKey,
  }) {
    BuildContext? ctx = (navKey ?? navigatorKey).currentContext;
    if (ctx == null) return;
    showSnackBar(
      context: ctx,
      message: msg,
      snackBarType: snackBarType,
    );
  }

  static void errorSnackbar(String msg) {
    BuildContext? ctx = (navigatorKey).currentContext;
    if (ctx == null) return;
    showSnackBar(
      context: ctx,
      message: msg,
      snackBarType: SnackBarType.error,
    );
  }

  static void infoSnackbar(String msg) {
    BuildContext? ctx = (navigatorKey).currentContext;
    if (ctx == null) return;
    showSnackBar(
      context: ctx,
      message: msg,
      snackBarType: SnackBarType.info,
    );
  }

  static void successSnackbar(String msg) {
    BuildContext? ctx = (navigatorKey).currentContext;
    if (ctx == null) return;
    showSnackBar(
      context: ctx,
      message: msg,
      snackBarType: SnackBarType.success,
    );
  }

  static String formatDuration(Duration d) {
    var seconds = d.inSeconds;
    final days = seconds ~/ Duration.secondsPerDay;
    seconds -= days * Duration.secondsPerDay;
    final hours = seconds ~/ Duration.secondsPerHour;
    seconds -= hours * Duration.secondsPerHour;
    final minutes = seconds ~/ Duration.secondsPerMinute;
    seconds -= minutes * Duration.secondsPerMinute;

    final List<String> tokens = [];
    if (days != 0) {
      tokens.add('$days day${putS(days)}');
    }
    if (tokens.isNotEmpty || hours != 0) {
      tokens.add('$hours hour${putS(hours)}');
    }
    if (tokens.isNotEmpty || minutes != 0) {
      tokens.add('$minutes minute${putS(minutes)}');
    }
    tokens
        .add('${seconds < 10 ? '0$seconds' : seconds} second${putS(seconds)}');

    return tokens.join(' ');
  }

  static String putS(int n, [bool capital = false]) {
    if (n > 1) {
      return capital ? 'S' : 's';
    } else {
      return '';
    }
  }

  static T? stringToEnum<T>(String value, List<T> enumValues) {
    for (var enumValue in enumValues) {
      if (enumValue.toString().split('.').last == value) {
        return enumValue;
      }
    }
    return null;
  }

  static Future<bool> internetCheck() async {
    // return true;
    try {
      String url = 'https://www.google.com';
      Dio dio = Dio();
      dio.options.receiveTimeout = const Duration(milliseconds: 3000);
      dio.options.sendTimeout = const Duration(milliseconds: 3000);
      dio.options.connectTimeout = const Duration(milliseconds: 3000);

      await dio.get(url);
      return true;
    } catch (e) {
      return false;
    }
  }
}
