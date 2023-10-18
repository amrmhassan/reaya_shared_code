// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:reaya_shared_code/init/runt_time_variables.dart';

Future<void> _handleBackgroundMessage(RemoteMessage message) async {
  print('title: ${message.notification?.title}');
  print('body: ${message.notification?.body}');
  print('payload: ${message.data}');
}

class FirebaseNotifications {
  static final onNotifications = StreamController<Message?>();

  final _firebaseMessaging = FirebaseMessaging.instance;
  final _localNotifications = FlutterLocalNotificationsPlugin();
  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High importance channel',
    description: 'this channel is used for important notifications',
    importance: Importance.defaultImportance,
  );

  Future<String> getFCMToken() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    return fCMToken ?? '';
  }

  Future<void> init() async {
    await getFCMToken();
    _initPushNotification();
    initLocalNotifications();
  }

  void _handleMessage(RemoteMessage? message) {
    if (message == null) return;
    // here do your navigation and whatever your want
    if (navigatorKey.currentContext == null) return;
    String? pharmacyId = message.data['pharmacyId'];
    //? here handle routing the message to chat screen or to message
    if (pharmacyId == null) return;
    String? type = message.data['type'];
    logger.e(type);
    //? skip the message foreground message
    //! here what to do after clicking the notification
  }

  Future<void> initLocalNotifications() async {
    const ios = DarwinInitializationSettings();
    const android = AndroidInitializationSettings('@drawable/ic_launcher');
    const settings = InitializationSettings(iOS: ios, android: android);
    await _localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (details) {
        var payload = details.payload;
        if (payload == null) return;
        final message = RemoteMessage.fromMap(jsonDecode(payload));
        _handleMessage(message);
      },
    );
    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  Future<void> _initPushNotification() async {
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    _firebaseMessaging.getInitialMessage().then(_handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
    FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;
      String? type = message.data['type'];
      //? skip the message foreground message
      if (type == 'message') return;
      _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _androidChannel.id,
            _androidChannel.name,
            channelDescription: _androidChannel.description,
            icon: '@drawable/ic_launcher',
          ),
        ),
        payload: jsonEncode(message.toMap()),
      );
    });
  }

  FirebaseMessaging get instance => _firebaseMessaging;
}
