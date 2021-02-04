import 'dart:async';
import 'package:demo_desktop/utilities/check_platform.dart';
import 'package:demo_desktop/utilities/custom_navigator.dart';
import 'package:demo_desktop/utilities/globals.dart';
import 'package:flutter/material.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  String _platform = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (ApplicationPlatform.isAndroid) {
      _platform = "Android";
    } else if (ApplicationPlatform.isIOS) {
      _platform = "IOS";
    } else if (ApplicationPlatform.isLinux) {
      _platform = "Linux";
    } else if (ApplicationPlatform.isMacOS) {
      _platform = "MacOS";
    } else if (ApplicationPlatform.isWindows) {
      _platform = "Window";
    } else if (ApplicationPlatform.isWeb) {
      _platform = "Web";
    } else {
      _platform = "undefined platform";
    }
    Future.delayed(Duration(seconds: 5))
        .then((value) => CustomNavigator().pushName(
              context, "/LoginPage",));

    WidgetsBinding.instance.addPostFrameCallback((_) {
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Globals().init(context: context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(
                  bottom: Globals.maxPadding,
                ),
                width: Globals.maxPadding * 5,
                height: Globals.maxPadding * 5,
                child: Image.asset("assets/logo-mobisale.png"),
              ),
              Container(
                width: Globals.maxWidth,
                height: Globals.maxHeight / 3,
                child: Image.asset("assets/splash_background.png"),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(
                      bottom: Globals.minPadding, top: Globals.minPadding),
                  child: Text(
                    _platform,
                    style: TextStyle(
                        fontSize: Globals.maxPadding,
                        fontWeight: FontWeight.w800),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
