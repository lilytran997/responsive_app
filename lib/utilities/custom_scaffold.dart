
import 'package:demo_desktop/common/constant.dart';
import 'package:demo_desktop/utilities/custom_appbar.dart';
import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  final String title;
  final Widget customAppBar;
  final bool enableBack;
  final Function onBackTap;
  final String iconAction;
  final String iconBack;
  final Function onTapAction;
  final Widget body;
  final Widget floatingActionButton;
  final Color backgroundColor;
  final Color appBarColor;
  final Color colorTitle;
  final RefreshCallback onRefresh;
  final GlobalKey<ScaffoldState> scaffoldKey;

  CustomScaffold(
      {this.title,
        this.customAppBar,
        this.enableBack = true,
        this.onBackTap,
        this.iconAction,
        this.onTapAction,
        this.body,
        this.floatingActionButton,
        this.backgroundColor,
        this.onRefresh,
        this.scaffoldKey,
        this.iconBack,
        this.appBarColor, this.colorTitle})
      : assert(enableBack != null);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: backgroundColor ?? bigStone02Color,
      body: Container(
        child: Column(
          children: <Widget>[
            title == null
                ? (customAppBar == null ? Container() : customAppBar)
                : CustomAppbar(
              title: title,
              onTapAction: onTapAction,
              iconAction: iconAction,
              enableBack: enableBack,
              onBackTap: onBackTap,
              backgroundColor: appBarColor ?? Colors.white,
              iconBack: iconBack,
              colorTitle: colorTitle,
            ),
            Expanded(
              child: onRefresh == null
                  ? (body ?? Container())
                  : RefreshIndicator(
                  child: body ?? Container(), onRefresh: onRefresh),
            )
          ],
        ),
      ),
      floatingActionButton: floatingActionButton ?? Container(),
    );
  }
}