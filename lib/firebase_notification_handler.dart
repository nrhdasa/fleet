import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseNotifications {

  Future<void> setUpFirebase(GlobalKey navigatorKey) async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      'This channel is used for important notifications.', // description
      importance: Importance.max,
    );
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS
    );
    await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
      onSelectNotification: (String? payload) async {
        BuildContext context = navigatorKey.currentState!.context;
        Map<String,dynamic> data = jsonDecode(payload??"");
        Navigator.pushNamed(context, data['route'],arguments:data['scode'] );
      }
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      // If `onMessage` is triggered with a notification, construct our own
      // local notification to show to users using the created channel.
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                icon: android.smallIcon
                // other properties...
              ),
            ),
            payload: jsonEncode(message.data)
        );
      }
    });
    FirebaseMessaging.onBackgroundMessage((message) => _messageHandler(message,navigatorKey.currentState!.context));
  }
  Future<void> _messageHandler(RemoteMessage message,BuildContext context) async {
    Map data = jsonDecode(message.data['data']);
    if(data.containsKey('scode')){
      Navigator.pushNamed(context, data['route'],arguments:data['scode'] );
    }
  }
}