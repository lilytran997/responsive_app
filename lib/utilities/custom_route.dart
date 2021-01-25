import 'package:flutter/cupertino.dart';

class CustomRoute extends PageRouteBuilder {
  final Widget page;
  final bool opaque;
  final bool isHero;
  CustomRoute({this.page, this.opaque = true, this.isHero = false})
      : super(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) =>
      page,
      transitionsBuilder: (BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child) =>
      (isHero || !opaque)
          ? FadeTransition(
        opacity: Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(animation),
        child: child,
      )
          : SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      ),
      opaque: opaque,
      transitionDuration: Duration(milliseconds: isHero ? 1500 : 300));

  @override
  // TODO: implement settings
  RouteSettings get settings => opaque
      ? RouteSettings(name: page.runtimeType.toString())
      : super.settings;
}
