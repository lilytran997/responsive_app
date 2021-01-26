import 'package:demo_desktop/utilities/check_platform.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PermissionRequest {

  static openSetting({BuildContext context, PermissionRequestType type}) {
    final channel = MethodChannel("flutter.io/requestPermission");
    if(type == null){
      channel.invokeMethod('open_screen');
    }
    else{
      assert (context != null);
      String permission;
      if(type == PermissionRequestType.CAMERA){
        permission = "Camera";
      }
      else if(type == PermissionRequestType.LOCATION){
        permission = "Location";
      }
      else if(type == PermissionRequestType.RECORD_AUDIO){
        permission = "Microphone";
      }
      else if(type == PermissionRequestType.STORAGE){
        permission = "Memory";
      }
//      return openDialog(context, "Chọn Cài đặt vào Thông tin ứng dụng, chọn vào Quyền (Permissions) và bật truy cập " + permission,
//          title: "Cho phép quyền truy cập " + permission,
//          options: [
//            CustomOptionDialog("Hủy",
//                isMain: false, onTap: () => navigatorPop(context)),
//            CustomOptionDialog("Cài đặt",
//                onTap: (){
//                  navigatorPop(context);
//                  channel.invokeMethod('open_screen');
//                })
//          ]);
    }
  }

  static Future<bool> request(BuildContext context, PermissionRequestType type) async {
    final channel = MethodChannel("flutter.io/requestPermission");
    bool event = false;
    int result = 0;

    try{
      if(type == PermissionRequestType.CAMERA){
        result = await channel.invokeMethod<int>('camera');
      }
      else if(type == PermissionRequestType.LOCATION){
        result = await channel.invokeMethod<int>('location');
      }
      else if(type == PermissionRequestType.RECORD_AUDIO){
        result = await channel.invokeMethod<int>('record_audio');
      }
      else if(type == PermissionRequestType.STORAGE){
        if(ApplicationPlatform.isAndroid){
          result = await channel.invokeMethod<int>('storage');
        }
        else
          result = 1;
      }
    }
    catch(_){}

    if(result == -1)
      await openSetting(context: context, type: type);
    else if(result == 1)
      event = true;

    return event;
  }

  static Future<bool> check(PermissionRequestType type) async {
    final channel = MethodChannel("flutter.io/checkPermission");
    int result = 0;
    try{
      if(type == PermissionRequestType.CAMERA){
        result = await channel.invokeMethod<int>('camera');
      }
      else if(type == PermissionRequestType.LOCATION){
        result = await channel.invokeMethod<int>('location');
      }
      else if(type == PermissionRequestType.RECORD_AUDIO){
        result = await channel.invokeMethod<int>('record_audio');
      }
      else if(type == PermissionRequestType.STORAGE){
        result = await channel.invokeMethod<int>('storage');
      }
    }
    catch(_){}

    return result == 1?true:false;
  }
}

enum PermissionRequestType{
  CAMERA, LOCATION, RECORD_AUDIO, STORAGE
}

enum PermissionResult{
  GRANTED, DENIED, NEVER_ASK_AGAIN
}