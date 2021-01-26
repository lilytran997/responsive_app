//
// Created by admin on 1/25/2021.
//

#include "include/flutter_win_webview/flutter_win_webview_plugin.h"

#include <flutter/flutter_view.h>
#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/standard_method_codec.h>
#include <windows.h>

#include <string>
#include <vector>
#include <wrl.h>
#include <wil/com.h>
#include "WebView2.h"

using namespace Microsoft::WRL;

namespace {

using flutter::EncodableList;
using flutter::EncodableMap;
using flutter::EncodableValue;

// See channel_controller.dart for documentation.
const char kChannelName[] = "flutter/webViewWindow";
const char kShowOpenAuthWindowMethod[] = "WebViewWindow.Show.Open";

// Pointer to WebViewController
static wil::com_ptr<ICoreWebView2Controller> webViewController;

// Pointer to WebView window
static wil::com_ptr<ICoreWebView2> webviewWindow;


// Returns the top-level window that owns |view|.
HWND GetRootWindow(flutter::FlutterView *view) {
  return GetAncestor(view->GetNativeWindow(), GA_ROOT);
}

class WebviewWindowPlugin : public flutter::Plugin {
public:
	static void RegisterWithRegistrar(flutter::PluginRegistrar* registrar);

	virtual ~WebviewWindowPlugin();

private:
	WebviewWindowPlugin();

	// Called when a method is called on plugin channel;
	void HandleMethodCall(const flutter::MethodCall<>& method_call,
		std::unique_ptr<flutter::MethodResult<>> result);
};



// static
void WebviewWindowPlugin::RegisterWithRegistrar(
    flutter::PluginRegistrar*registrar) {
  auto channel =
      std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
          registrar->messenger(), kChannelName,
          &flutter::StandardMethodCodec::GetInstance());

  auto plugin = std::make_unique<WebviewWindowPlugin>(registrar);

  channel->SetMethodCallHandler(
      [plugin_pointer = plugin.get()](const auto &call, auto result) {
        plugin_pointer->HandleMethodCall(call, std::move(result));
      });

  registrar->AddPlugin(std::move(plugin));
}

WebviewWindowPlugin::WebviewWindowPlugin() = default;

WebviewWindowPlugin::~WebviewWindowPlugin() = default;

void WebviewWindowPlugin::HandleMethodCall(
    const flutter::MethodCall<flutter::EncodableValue> &method_call,
    std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result) {

  OutputDebugStringA(method_call.method_name().c_str());
  if (method_call.method_name().compare(kShowOpenAuthWindowMethod) == 0) {
    if (!method_call.arguments() || !method_call.arguments()->IsString()) {
      result->Error("Bad Arguments", "Argument map missing or malformed");
      return;
    }
    auto url = method_call.arguments()->StringValue();
    OutputDebugStringA(url.c_str());

	auto hwnd = GetRootWindow(registrar_->GetView());

	CreateCoreWebView2EnvironmentWithOptions(nullptr, nullptr, nullptr,
		Callback<ICoreWebView2CreateCoreWebView2EnvironmentCompletedHandler>(
			[hwnd](HRESULT result, ICoreWebView2Environment* env) -> HRESULT {

				// Create a CoreWebView2Controller and get the associated CoreWebView2 whose parent is the main window hWnd
				env->CreateCoreWebView2Controller(hwnd, Callback<ICoreWebView2CreateCoreWebView2ControllerCompletedHandler>(
					[hwnd](HRESULT result, ICoreWebView2Controller* controller) -> HRESULT {
						if (controller != nullptr) {
							webViewController = controller;
							webViewController->get_CoreWebView2(&webviewWindow);
						}

						// Add a few settings for the webview
						// The demo step is redundant since the values are the default settings
						ICoreWebView2Settings* Settings;
						webviewWindow->get_Settings(&Settings);
						Settings->put_IsScriptEnabled(TRUE);
						Settings->put_AreDefaultScriptDialogsEnabled(TRUE);
						Settings->put_IsWebMessageEnabled(TRUE);

						// Resize WebView to fit the bounds of the parent window
						RECT bounds;
						GetClientRect(hwnd, &bounds);
						bounds.top += 50;
						bounds.left += 50;
						bounds.right -= 50;
						bounds.bottom -= 50;
						webViewController->put_Bounds(bounds);

						// Schedule an async task to navigate to Bing
						webviewWindow->Navigate(L"https://www.bing.com/");

						return S_OK;
					}).Get());
				return S_OK;
			}).Get());

	MSG msg;
	while (GetMessage(&msg, NULL, 0, 0))
	{
		TranslateMessage(&msg);
		DispatchMessage(&msg);
	}

    //EncodableValue response("FAKEHASH");

    //result->Success(&response);
  } else {
    result->NotImplemented();
  }
}

}  // namespace

void WebViewWindowRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
	WebviewWindowPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}