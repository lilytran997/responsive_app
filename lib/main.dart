

import 'package:demo_desktop/common/constant.dart';
import 'package:demo_desktop/home_tabbar/src/ui/home_tabbar_widget.dart';
import 'package:demo_desktop/login/login_widget.dart';
import 'package:demo_desktop/splash/splash_screen_widget.dart';
import 'package:demo_desktop/utilities/check_platform.dart';
import 'package:demo_desktop/utilities/custom_route.dart';
import 'package:flutter/material.dart';
void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // html.window.history.pushState(null, "#", "/");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  String _platform ="";
  @override
  Widget build(BuildContext context) {
    changeStatusBarColor(Colors.transparent, true);
    if (ApplicationPlatform.isAndroid) {
      _platform= "Mobisale";
    } else if (ApplicationPlatform.isIOS) {
      _platform = "Mobisale";
    } else if (ApplicationPlatform.isLinux) {
      _platform = "Appsale";
    } else if (ApplicationPlatform.isMacOS) {
      _platform = "Appsale";
    } else if (ApplicationPlatform.isWindows) {
      _platform = "Appsale";
    } else if (ApplicationPlatform.isWeb) {
      _platform = "Websale";
    } else {
      _platform = "undefined platform";
    }
    return MaterialApp(
      title: _platform??"",
      initialRoute: "/SplashPage",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreenPage(),
      routes: <String, WidgetBuilder>{
        '/HomePage': (BuildContext context) => HomeTabbarPage(),
        '/LoginPage': (BuildContext context) => LoginPage(),
        '/SplashPage': (BuildContext context) => SplashScreenPage(),
      },
      onGenerateRoute: (settings) {
        print(settings.name);
        switch (settings.name) {
          case "/":
            return CustomRoute(
                page: SplashScreenPage(),
                opaque: true,
                isHero: false
            );
          case "/HomePage":
            return CustomRoute(
                page: HomeTabbarPage(),
                opaque: true,
                isHero: false
            );
          case "/LoginPage":
            return CustomRoute(
                page: LoginPage(),
                opaque: true,
                isHero: false
            );
          case "/SplashPage":
            return CustomRoute(
                page: SplashScreenPage(),
                opaque: true,
                isHero: false
            );
          default:
            return CustomRoute(
                page: SplashScreenPage(),
                opaque: true,
                isHero: false
            );
        }
      },
    );
  }
}
