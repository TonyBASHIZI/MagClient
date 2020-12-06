import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:io' show File, Platform;

import 'package:rxdart/rxdart.dart';
// import 'package:rxdart/subject.dart';

class NotificationPlugin {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  final BehaviorSubject<ReceivedNotification> didReceivedNotification =
      BehaviorSubject<ReceivedNotification>();
  var initializationSettings;
  NotificationPlugin._() {
    init();
  }

  init() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    if (Platform.isIOS) {
      _requestIOSPermission();
    }
    initializePlateformSpecifics();
  }

  initializePlateformSpecifics() {
    var initializeSettingAndroid =
        AndroidInitializationSettings('app_notf_icon');
    var initializeSettingsIOS = IOSInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: false,
        onDidReceiveLocalNotification: (id, title, body, playload) async {
          ReceivedNotification receivedNotification = ReceivedNotification(
              id: id, title: title, body: body, playload: playload);
          didReceivedNotification.add(receivedNotification);
        });

    initializationSettings =
        InitializationSettings(initializeSettingAndroid, initializeSettingsIOS);
  }

  _requestIOSPermission() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        .requestPermissions(
          alert: false,
          badge: false,
          sound: true,
        );
  }

  setListenerLowerVersions(Function onNotificationInLowerVersions) {
    didReceivedNotification.listen((receivedNotification) {
      onNotificationInLowerVersions(receivedNotification);
    });
  }

  setOnNotificationClick(Function onNotificationClick) async {
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async {
      onNotificationClick(payload);
    });
  }

  Future<void> showNotification() async {
    var androidChannelSpecifics = AndroidNotificationDetails(
        "CHANNEL_ID", "CHANNEL_NAME", "CHANNEL_DESCRIPTION");
    var iosChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpacifics =
        NotificationDetails(androidChannelSpecifics, iosChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'TITRE YES', 'BODY TEST', platformChannelSpacifics, payload: 'Test');
  }
}

NotificationPlugin notificationPlugin = NotificationPlugin._();

class ReceivedNotification {
  final int id;
  final String title;
  final String body;
  final String playload;

  ReceivedNotification({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.playload,
  });
}
