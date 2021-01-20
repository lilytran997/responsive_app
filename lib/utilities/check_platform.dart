import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart' show kIsWeb;

class ApplicationPlatform {
  static final ApplicationPlatform _shared =
  new ApplicationPlatform._internal();
  static ApplicationPlatform get shared => _shared;
  static bool get isIOS => _isWeb() ? false : Platform.isIOS;
  static bool get isAndroid => _isWeb() ? false : Platform.isAndroid;
  static bool get isWeb => _isWeb();
  static bool get isWindows => _isWeb() ? false : Platform.isWindows;
  static bool get isLinux => _isWeb() ? false : Platform.isLinux;
  static bool get isMacOS => _isWeb() ? false : Platform.isMacOS;
  factory ApplicationPlatform() {
    return _shared;
  }
  ApplicationPlatform._internal();

  static bool _isWeb() {
    return kIsWeb;
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

final primaryColor = HexColor("3E64FF");