import 'dart:async';

import 'package:demo_desktop/utilities/firebase_messaging/notification_helper.dart';
import 'package:demo_desktop/utilities/firebase_messaging/notification_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
/// Mobile-only helper to manage notifications.
class FirebaseMessagingHelper implements NotificationHelper {
  FirebaseMessagingHelper._internal();

  factory FirebaseMessagingHelper() => _instance;

  static final FirebaseMessagingHelper _instance =
  FirebaseMessagingHelper._internal();

  bool _isReady = false;
  String _token;

  final _firebaseMessaging = FirebaseMessaging.instance;
  final _controller = StreamController<NotificationModel>.broadcast();

  @override
  void close() {
    _controller?.close();
  }

  @override
  Future<String> getToken([bool force = false]) async {
    if (force || _token == null) {
      await requestPermission();
      _token = await _firebaseMessaging.getToken();
    }
    return _token;
  }

  @override
  Future<bool> get isReady async {
    if (kIsWeb) return false;
    if (!_isReady) _isReady = await _initialize();
    return _isReady;
  }

  Future<dynamic> _onMessageReceived(RemoteMessage payload) async {
    if (payload.notification.title != null && payload.notification.body != null){

      final notif = NotificationModel(body: payload.notification.body,title:payload.notification.title );
      _controller.add(notif);
    }
  }

  Future<bool> _initialize() async {
    try {
      // For iOS request permission first
      await requestPermission();
      FirebaseMessaging.onMessage.listen((event) {
        print("onMessage: $event");
        _onMessageReceived(event);
      });
      FirebaseMessaging.onMessageOpenedApp.listen((event) {
        print("onMessageOpenedApp: $event");
        _onMessageReceived(event);
      });
      return true;
    } catch (e) {
      print('Error while initializing: ${e.toString()}');
      return false;
    }
  }

  @override
  Stream<NotificationModel> get stream => _controller.stream;

  @override
  Future<dynamic> requestPermission() async {
    return _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }
}