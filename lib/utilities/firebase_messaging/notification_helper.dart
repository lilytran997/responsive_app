
import 'package:demo_desktop/utilities/firebase_messaging/notification_model.dart';

abstract class NotificationHelper {
  Future<bool> get isReady;
  Stream<NotificationModel> get stream;
  void close();
  Future<String> getToken([bool force = false]);
  Future<dynamic> requestPermission();
}