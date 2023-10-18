import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:reaya_shared_code/features/notifications/firebase_notifications.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
Logger logger = Logger();
FirebaseAuth firebaseAuth = FirebaseAuth.instance;
Dio dio = Dio();
FirebaseNotifications firebaseNotifications = FirebaseNotifications();
