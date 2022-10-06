import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PushNotificationsManager {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  PushNotificationsManager._();

  factory PushNotificationsManager() => _instance;
  static final PushNotificationsManager _instance = PushNotificationsManager._();
  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  bool _initialized = false;
  GetStorage box = GetStorage();
  Future<void> init() async {
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {

    });

    if (!_initialized) {
      print('initial fcm');
      if (Platform.isIOS) {
        await FirebaseMessaging.instance.requestPermission(
            // const IosNotificationSettings(sound: true, badge: true, alert: true),
            );
      } else {
        await FirebaseMessaging.instance.requestPermission();
      }
      await FirebaseMessaging.instance.subscribeToTopic('all');
      RemoteNotification notification;
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        notification = message.notification!;
        print('onMesssage: $message');
        _pushNotification(
          title: notification.title!,
          content: notification.body!,
        );
      });
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print('A new onMessageOpenedApp event was published!');
        print(message);
      });
      print('initial config');
      String? token = await FirebaseMessaging.instance.getToken();
      print("Token: $token");
      box.write('fcm_token', "$token");
      _initialized = true;
      await initNotificationService();
      return;
    }
  }

  Future initNotificationService() async {
    AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings(
      onDidReceiveLocalNotification: (int? id, String? title, String? body, String? payload) async {
        print('IOSInitializationSettings');
       return await Future.delayed(Duration(seconds: 1),(){

       });
      },
    );
    MacOSInitializationSettings initializationSettingsMacOS = MacOSInitializationSettings();
    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
      macOS: initializationSettingsMacOS,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: _handleOpenNotify,
    );
    return;
  }

  _pushNotification({
    String? title,
    String? content,
  }) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      importance: Importance.max,
      priority: Priority.high,
    );
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      content,
      platformChannelSpecifics,
      payload: json.encode({'title': title, 'content': content}),
    );
  }

  Future _handleOpenNotify(message) async {
    // String token = await Store().getTokenFcm();
    bool isLogged = box.hasData('token');

    if (isLogged) {}
  }
}
