import 'package:demo_desktop/utilities/firebase_messaging/notification_helper.dart';
import 'mobile_firebase_messaging.dart'
if (dart.library.js) 'web_firebase_messaging.dart' as notifInstance;

abstract class NotificationEncapsulation {
  static NotificationHelper get instance =>
      notifInstance.FirebaseMessagingHelper();
}