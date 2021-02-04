import 'dart:async';

import 'package:demo_desktop/utilities/firebase_messaging/notification_helper.dart';
import 'package:demo_desktop/utilities/firebase_messaging/notification_model.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase/firebase.dart' as firebaseWeb;

/// Web-only helper to manage notifications.
class FirebaseMessagingHelper implements NotificationHelper {
  FirebaseMessagingHelper._internal();

  factory FirebaseMessagingHelper() => _instance;

  static final FirebaseMessagingHelper _instance =
  FirebaseMessagingHelper._internal();

  bool _isReady = false;
  String _token;

  final _controller = StreamController<NotificationModel>.broadcast();

  firebaseWeb.Messaging _messaging;

  @override
  Future<String> getToken([bool force = false]) async {
    if (force || _token == null) {
      await requestPermission();
      _token = await _messaging.getToken();
    }
    return _token;
  }

  @override
  Future<dynamic> requestPermission() => _messaging.requestPermission();

  @override
  Future<bool> get isReady async {
    if (!kIsWeb) return false;
    if (!_isReady) _isReady = await _initialize();
    return _isReady;
  }

  Future<bool> _initialize() async {
    try {
      _messaging = firebaseWeb.messaging();
      _messaging.usePublicVapidKey('BEGtF1_ZIcyi_dQlol1Sj9Es2vOhzEc0RedOEz26eRzYSJIgMo7NDZuPa3GsBPJ9936PXj5huuUqmeENzzZVlAg');
      _messaging.onMessage.listen((event) {
        event.notification.title;
        _controller.add(NotificationModel(
          title: event?.notification?.title,
          body: event?.notification?.body,
        ));
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
  void close() {
    _controller?.close();
  }
}