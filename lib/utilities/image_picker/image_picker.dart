import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:demo_desktop/utilities/check_platform.dart';
import 'package:demo_desktop/utilities/custom_navigator.dart';
import 'package:demo_desktop/utilities/file_picker_win/filepicker_windows.dart';
// import 'package:demo_desktop/utilities/file_picker_win/filepicker_windows.dart';
import 'package:demo_desktop/utilities/image_picker/camera/custom_camera.dart';
import 'package:demo_desktop/utilities/permission_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:universal_html/html.dart' as html;

class ApplicationResult {
  File file;
  Image image;
  Uint8List bytes;
}

class ApplicationImagePicker {
  static Future<ApplicationResult> pickImage(BuildContext context,
      {@required ImageSource source,
      double maxWidth,
      double maxHeight,
      int imageQuality}) async {
    assert(source != null);
    try {
      bool permission = false;
      if (source == ImageSource.camera) {
        permission = await cameraPermission(context);
      } else {
        if (ApplicationPlatform.isAndroid) {
          permission = await storagePermission(context);
        } else {
          permission = true;
        }
      }
      if (!permission) return null;
    } catch (_) {
      return null;
    }
    if (source == ImageSource.camera && ApplicationPlatform.isAndroid) {
      List<CameraDescription> cameras = [];
      cameras = await availableCameras();
      if (cameras == null || cameras.length == 0) {
        CustomNavigator().showCustomAlertDialog(context,"Thông báo", "Điện thoại bạn không có hỗ trợ chức năng camera");
        return null;
      }
      Future.delayed(Duration(seconds: 2));
      List<dynamic> resultCamera = await CustomNavigator().push(context,
          CameraAndroidHome(cameras: cameras, isForceFrontCamera: false));
      if (resultCamera.length == 0) {
        return null;
      }
      File image = resultCamera[0];
      ApplicationResult result = ApplicationResult();
      result.file = await compressImage(image);
      return result;
    } else if (source == ImageSource.gallery && ApplicationPlatform.isAndroid) {
      String event = await MethodChannel("flutter.io/gallery")
          .invokeMethod<String>('gallery');
      if (event == null) return null;
      ApplicationResult result = ApplicationResult();
      result.file = File(event);
      return result;
    } else if(ApplicationPlatform.isIOS) {
      final picker = ImagePicker();
      final _image = await picker.getImage(
          source: source,
          maxHeight: 2450,
          maxWidth: 1750,
          imageQuality: imageQuality);
      if (_image != null && _image.path != null) {
        ApplicationResult result = ApplicationResult();
        result.file = await compressImage(File(_image.path));
        return result;
      } else {
        return null;
      }
    }else if(ApplicationPlatform.isWeb){
      final completer = new Completer<String>();
      final html.InputElement input = html.document.createElement('input');
      input
        ..type = 'file'
        ..accept = 'image/*';
      ApplicationResult result = ApplicationResult();
      input.addEventListener('change', (e) async {
        final List<html.File> files = input.files;
        final reader = new html.FileReader();
        reader.readAsDataUrl(files[0]);
        reader.onError.listen((error) => completer.completeError(error));
        await reader.onLoad.first;
        completer.complete(reader.result as String);
      });
      input.click();
      final encoded = await completer.future;
      final stripped =
      encoded.replaceFirst(RegExp(r'data:image/[^;]+;base64,'), '');
      Uint8List data = base64.decode(stripped);
      result.image = Image.memory(data);
      result.bytes = data;
      return result;
    }else{
      //windows
      final file = OpenFilePicker();
      file.hidePinnedPlaces = true;
      file.forcePreviewPaneOn = true;
      file.filterSpecification = {
        'JPEG Files': '*.jpg;*.jpeg',
        'Bitmap Files': '*.bmp',
        'All Files (*.*)': '*.*'
      };
      file.title = 'Select an image';
      File image = file.getFile();
      if (image != null) {
        ApplicationResult result = ApplicationResult();
        result.file = await compressImage(File(image.path));
        return result;
      }
      return null;
    }
  }

  static Future<File> compressImage(File imageFile) async {
    File compressedFile;
    var length = await imageFile.length();
    if (length > 1045504) {
      compressedFile =
          await FlutterNativeImage.compressImage(imageFile.path, quality: 80);
      length = await compressedFile.length();
      if (length > 1045504) {
        compressedFile =
            await FlutterNativeImage.compressImage(imageFile.path, quality: 60);
        length = await compressedFile.length();
      } else {
        if (length > 1045504) {
          compressedFile = await FlutterNativeImage.compressImage(
              imageFile.path,
              quality: 40);
          length = await compressedFile.length();
        } else {
          compressedFile = await FlutterNativeImage.compressImage(
              imageFile.path,
              quality: 20);
          length = await compressedFile.length();
        }
      }
    } else {
      compressedFile = imageFile;
    }
    return compressedFile;
  }

  static Future<bool> cameraPermission(BuildContext context) async {
    if (Platform.isAndroid) {
      if (await Permission.camera.isPermanentlyDenied) {
        await openAppSettings();
        PermissionStatus permission = await Permission.camera.status;
        if (permission == PermissionStatus.granted) {
          return true;
        }
        return false;
      } else {
        PermissionStatus permission = await Permission.camera.status;
        if (permission == PermissionStatus.granted) {
          return true;
        } else {
          return await PermissionRequest.request(
              context, PermissionRequestType.CAMERA);
        }
      }
    } else {
      PermissionStatus permission = await Permission.camera.status;
      if (permission == PermissionStatus.granted) {
        return true;
      } else if (permission == PermissionStatus.restricted ||
          permission == PermissionStatus.denied) {
        await openAppSettings();
        if (permission == PermissionStatus.granted) {
          return true;
        }
        return false;
      } else {
        PermissionStatus permission = await Permission.camera.status;
        if (permission == PermissionStatus.granted) {
          return true;
        } else {
          PermissionStatus permission = await Permission.camera.request();
          if (permission == PermissionStatus.granted) {
            return true;
          }
        }
        return false;
      }
    }
  }

  static Future<bool> storagePermission(BuildContext context) async {
    if (await Permission.storage.isPermanentlyDenied) {
      await openAppSettings();
      PermissionStatus permission = await Permission.storage.status;
      if (permission == PermissionStatus.granted) {
        return true;
      }
      return false;
    } else {
      PermissionStatus permission = await Permission.storage.status;
      if (permission == PermissionStatus.granted) {
        return true;
      } else {
        return await PermissionRequest.request(
            context, PermissionRequestType.STORAGE);
      }
    }
  }
}
