import 'package:demo_desktop/common/constant.dart';
import 'package:demo_desktop/home_tabbar/src/ui/home_tabbar_widget.dart';
import 'package:demo_desktop/login/login_widget.dart';
import 'package:demo_desktop/splash/splash_screen_widget.dart';
import 'package:demo_desktop/utilities/check_platform.dart';
import 'package:demo_desktop/utilities/custom_route.dart';
import 'package:demo_desktop/utilities/globals.dart';
import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as html;
import 'package:overlay_support/overlay_support.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // html.window.history.pushState(null, "#", "/");
  final String pathName = html.window.location.pathname;
  runApp(MyApp(
    pathName: pathName,
  ));
}

class MyApp extends StatelessWidget {
  final String pathName;

  MyApp({
    this.pathName,
  });
  // This widget is the root of your application.
  String _platform = "";
  @override
  Widget build(BuildContext context) {
    changeStatusBarColor(Colors.transparent, true);
    if (ApplicationPlatform.isAndroid) {
      _platform = "Mobisale";
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
    print(pathName.toString());
    return OverlaySupport(
        child: MaterialApp(
          title:  _platform??"",
          initialRoute: "/SplashPage",
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,),
          builder: (context, child) {
            Globals().init(context: context);
            return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: child);
          },
          home: SplashScreenPage(),
          routes: <String, WidgetBuilder>{
            '/HomePage': (BuildContext context) => HomeTabbarPage(),
            '/LoginPage': (BuildContext context) => LoginPage(),
            '/SplashPage': (BuildContext context) => SplashScreenPage(),
          },
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case "/":
                // html.window.history.pushState(null, "/SplashPage", "/SplashPage");
                return CustomRoute(
                    page: SplashScreenPage(), opaque: true, isHero: false);
              case "/HomePage":
                // html.window.history.pushState(null, "/HomePage", "/HomePage");
                return CustomRoute(
                    page: HomeTabbarPage(), opaque: true, isHero: false);
              case "/LoginPage":
                // html.window.history.pushState(null, "/LoginPage", "/LoginPage");
                return CustomRoute(page: LoginPage(), opaque: true, isHero: false);
              case "/SplashPage":
                html.window.history.pushState(null, "/SplashPage", "/SplashPage");
                return CustomRoute(
                    page: SplashScreenPage(), opaque: true, isHero: false);
              default:
                return CustomRoute(
                    page: SplashScreenPage(), opaque: true, isHero: false);
            }
          },
        ));
  }
}
