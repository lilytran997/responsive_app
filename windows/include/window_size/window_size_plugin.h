//
// Created by admin on 1/8/2021.
//

#ifndef DEMO_DESKTOP_WINDOW_SIZE_PLUGIN_H
#define DEMO_DESKTOP_WINDOW_SIZE_PLUGIN_H

#endif //DEMO_DESKTOP_WINDOW_SIZE_PLUGIN_H
#include <flutter_plugin_registrar.h>

#ifdef FLUTTER_PLUGIN_IMPL
#define FLUTTER_PLUGIN_EXPORT __declspec(dllexport)
#else
#define FLUTTER_PLUGIN_EXPORT __declspec(dllimport)
#endif

#if defined(__cplusplus)
extern "C" {
#endif

FLUTTER_PLUGIN_EXPORT void WindowSizePluginRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar);

#if defined(__cplusplus)
}  // extern "C"
#endif

#endif  // PLUGINS_WINDOW_SIZE_WINDOWS_WINDOW_SIZE_PLUGIN_H_