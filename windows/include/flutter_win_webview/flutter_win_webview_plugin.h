#ifndef RESPONSIVE_APP_WINDOWS_INCLUDE_FLUTTER_WIN_WEBVIEW_FLUTTER_WIN_WEBVIEW_PLUGIN_H
#define RESPONSIVE_APP_WINDOWS_INCLUDE_FLUTTER_WIN_WEBVIEW_FLUTTER_WIN_WEBVIEW_PLUGIN_H

// A plugin to allow resizing the window.

#include <flutter_plugin_registrar.h>

#ifdef FLUTTER_PLUGIN_IMPL
#define FLUTTER_PLUGIN_EXPORT __declspec(dllexport)
#else
#define FLUTTER_PLUGIN_EXPORT __declspec(dllimport)
#endif

#if defined(__cplusplus)
extern "C" {
#endif

    FLUTTER_PLUGIN_EXPORT void WebViewWindowRegisterWithRegistrar(
        FlutterDesktopPluginRegistrarRef registrar);

#if defined(__cplusplus)
}  // extern "C"
#endif

#endif  // RESPONSIVE_APP_WINDOWS_INCLUDE_FLUTTER_WIN_WEBVIEW_FLUTTER_WIN_WEBVIEW_PLUGIN_H_