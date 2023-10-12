import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io' show Platform;

class NotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var settings = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      prefs.setBool('notification', true);
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      log('User granted provisional permission');
      prefs.setBool('notification', true);
    } else {
      log('User declined or has not accepted permission');
      prefs.setBool('notification', false);
    }
    _messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    setupFirebaseMessagingListeners();
  }

  static setupFirebaseMessagingListeners() {
    FirebaseMessaging.onMessageOpenedApp.listen(onOpenedApp);
    FirebaseMessaging.onBackgroundMessage(onOpenedApp);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(message.notification!.title);
      log('Got a message whilst in the foreground!');
      log('Message data: ${message.data}');
      if (message.notification != null && Platform.isAndroid) {
      }
    });
  }

  static Future<void> onOpenedApp(RemoteMessage message) async {
    log('A new onMessageOpenedApp event was published!');
    log('Message data: ${message.data}');

    print(message.notification!.title);
    NotificationService._handleChatNotification(message);
  }

  static _handleChatNotification(message) async {
    print(message.notification!.title);
    }
}