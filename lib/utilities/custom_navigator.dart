import 'package:demo_desktop/utilities/custom_alert_dialog.dart';
import 'package:demo_desktop/utilities/custom_dialog.dart';
import 'package:demo_desktop/utilities/custom_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomNavigator {
  Future<dynamic> push(BuildContext context, Widget screen,
      {bool root = true, bool opaque = true, bool isHero = false}) {
    String name =
        screen.runtimeType.toString().replaceAll('Screen', '') + "Screen";
    return Navigator.of(context, rootNavigator: root)
        .push(CustomRoute(page: screen, opaque: opaque, isHero: isHero));
  }

  Future<dynamic> pushName(BuildContext context, String routeName,
      {bool root = true, bool opaque = true, bool isHero = false}) {
    return Navigator.of(context, rootNavigator: root).pushNamed(routeName);
  }

  Future<dynamic> pushNamedAndRemoveUntil(
      BuildContext context, String routeName,
      {bool root = true, bool opaque = true, bool isHero = false}) {
    return Navigator.of(context, rootNavigator: root).pushNamedAndRemoveUntil(
        routeName, (Route<dynamic> route) => route.isFirst);
  }

  popToScreen(BuildContext context, Widget screen, {bool root = true}) {
    String name =
        screen.runtimeType.toString().replaceAll('Screen', '') + "Screen";
    Navigator.of(context, rootNavigator: root).popUntil((route) =>
        (route.settings.name == screen.runtimeType.toString() ||
            route.isFirst));
  }

  popToRoot(BuildContext context, {bool root = true}) {
    Navigator.of(context, rootNavigator: root)
        .popUntil((route) => route.isFirst);
  }

  pop(BuildContext context, {dynamic object, bool root = true}) {
    if (object == null)
      Navigator.of(context, rootNavigator: root).pop();
    else
      Navigator.of(context, rootNavigator: root).pop(object);
  }

  Future<dynamic> pushReplacement(BuildContext context, Widget screen,
      {bool root = true, bool opaque = true, bool isHero = false}) {
    String name =
        screen.runtimeType.toString().replaceAll('Screen', '') + "Screen";
    return Navigator.of(context, rootNavigator: root).pushReplacement(
        CustomRoute(page: screen, opaque: opaque, isHero: isHero));
  }

  popToRootAndPushReplacement(BuildContext context, Widget screen,
      {bool root = true, bool opaque = true, bool isHero = false}) {
    String name =
        screen.runtimeType.toString().replaceAll('Screen', '') + "Screen";
    Navigator.of(context, rootNavigator: root)
        .popUntil((route) => route.isFirst);
    Navigator.of(context, rootNavigator: root).pushReplacement(
        CustomRoute(page: screen, opaque: opaque, isHero: isHero));
  }

  showCustomBottomDialog(BuildContext context, Widget screen,
      {bool root = true, isScrollControlled = true}) {
    String name =
        screen.runtimeType.toString().replaceAll('Screen', '') + "Screen";
    return showModalBottomSheet(
        context: context,
        useRootNavigator: root,
        isScrollControlled: isScrollControlled,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return GestureDetector(
            child: screen,
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  showCustomAlertDialog(BuildContext context, String title, String content,
      {bool root = true,
      Function onSubmitted,
      String textSubmitted,
      bool enableCancel = false,
      bool cancelable = true,
      String image}) {
    return push(
        context,
        CustomDialog(
          screen: CustomAlertDialog(
            title: title,
            content: content,
          ),
          cancelable: cancelable,
        ),
        opaque: false,
        root: root);
  }
}
