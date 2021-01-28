import 'package:demo_desktop/utilities/responsive.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Globals{
  static double maxWidth;
  static double maxHeight;
  static double maxPadding;
  static double minPadding;
  static double statusBarHeight;
  static double ratio;
  static SharedPreferences prefs;
  static double tabbarSize;

  static String userName = "";
  static String iBBLocationName = "";
  static String email = "";
  static String phoneNumber = "";
  static int locationId = 0;
  static ApplicationMode _applicationMode;
  static String versionName = "";
  static String keyKong = "";

  init({BuildContext context, ApplicationMode model}){
   if(context!=null){
     maxWidth = MediaQuery.of(context).size.width;
     maxHeight = MediaQuery.of(context).size.height;
     ratio = maxHeight / maxWidth;
     statusBarHeight = MediaQuery.of(context).padding.top;
     if(ResponsiveWidget.isSmallScreen(context)){
       if(ResponsiveWidget.isLargerWidth(context)){
         print("isLargerWidth");
         maxPadding = maxHeight * 0.05;
         minPadding = maxPadding / 2;
         tabbarSize = maxHeight / 10 * 7;
       }else{
         maxPadding = maxWidth * 0.05;
         minPadding = maxPadding / 2;
         tabbarSize = maxWidth / 10 * 7;
       }
     }else if(ResponsiveWidget.isMediumScreen(context)){
       if(ResponsiveWidget.isLargerWidth(context)){
         print("isLargerWidth");
         maxPadding = maxHeight * 0.05;
         minPadding = maxPadding / 2;
         tabbarSize = maxHeight / 10 * 7;
       }else{
         maxPadding = maxWidth * 0.05;
         minPadding = maxPadding / 2;
         tabbarSize = maxWidth / 10 * 7;
       }
     }else{
       print("isSmallScreen");
       maxPadding = 20;
       minPadding = maxPadding / 2;
       tabbarSize = maxWidth / 10 * 7;
     }
   }
   if(model!=null){
     _applicationMode = model;
   }
    SharedPreferences.getInstance().then((event) => prefs = event);
  }
  static String getKongTokenURL = "https://sapi.fpt.vn/token/GenerateToken";
  static String checkContainHTTP(String base, String url) {
    if( url.contains('http')){
    } else {
    }
    return url.contains('http') ? url : base + url;
  }

}
enum ApplicationMode { PRODUCTION, STAGING, DEVELOPMENT }