import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:reaya_shared_code/features/notifications/fcm_tokens_source.dart';

const String _serverKey =
    'AAAA2vwrzOc:APA91bEj-oNcNDvEHPqtB4G6u5IbFKyIGhmj2DrYBNTVZS9-_NuiPZkLNI56UDxclnBa09dcUm0UDUsLt_WmnzDbjvg6Fi-6PkneFJaqcOUPgZhGRa4ShRV1Qhy2jIXyKC5Zj1wOkb-H';
const String _url = 'https://fcm.googleapis.com/fcm/send';

class SendNotificationApi {
  static Future<void> sendNotification({
    required String userId,
    required String title,
    required String body,
    required Map<String, dynamic> payload,
  }) async {
    FCMTokensSource source = FCMTokensSource();
    String? token = await source.getUserFcmToken(userId);
    if (token == null) return;
    Map<String, String> dataParsed = {};
    payload.forEach((key, value) {
      dataParsed[key] = value.toString();
    });

    return _sendMessage(
      to: token,
      title: title,
      body: body,
      payload: dataParsed,
    );
  }

  static Future<void> _sendMessage({
    required String to,
    required String title,
    required String body,
    required Map<String, String> payload,
  }) async {
    var data = {
      'to': to,
      'priority': 'high',
      'notification': {
        'title': title,
        'body': body,
      },
      'data': payload,
    };
    await http.post(Uri.parse(_url), body: jsonEncode(data), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'key=$_serverKey'
    });
  }
}
