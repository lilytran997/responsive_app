

import 'package:flutter/services.dart';



/// The name of the plugin's platform channel.
const String _windowSizeChannelName = 'flutter/windowsize';
const String _webViewChannel= 'flutter/webViewWindow';
const String _webViewChannelName= "WebViewWindow.Show.Open";


/// The result of a popup web authentication operation.
class WebViewWindowResult {
  /// Creates a new result object with the given state and paths.
  const WebViewWindowResult({this.token, this.canceled});

  /// Whether or not the authentication operation was canceled by the user.
  final bool canceled;

  /// A token returned from authentication request. If [canceled] is true, it
  /// should always be empty.
  final String token;
}

/// A singleton object that controls web authentication interactions with windows.
class WebViewWindowChannelController {
  WebViewWindowChannelController._();

  /// The platform channel used to manage popup auth
  ///
  final _channel = new MethodChannel(_webViewChannel);

  /// A reference to the singleton instance of the class.
  static final WebViewWindowChannelController instance =
  new WebViewWindowChannelController._();

  /// Shows a Webauth popup, returning a
  /// [WebViewWindowResult] when complete.
  Future<WebViewWindowResult> show(
      String url,
      ) async {
    final token = await _channel.invokeMethod<String>(_webViewChannelName, url);
    return WebViewWindowResult(token: token ?? [], canceled: token == null);
  }
}

/// Shows a modal web authentication dialog.
///
/// A number of configuration options are available:
/// - [url] URL to point browser to.
Future<WebViewWindowResult> showOpenBrowser({String url}) async {
  return WebViewWindowChannelController.instance.show(url);
}