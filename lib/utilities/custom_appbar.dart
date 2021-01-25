
import 'package:demo_desktop/common/constant.dart';
import 'package:demo_desktop/utilities/globals.dart';
import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  final String title;
  final bool enableBack;
  final Function onBackTap;
  final String iconAction;
  final Function onTapAction;
  final Color backgroundColor;
  final String iconBack;
  final Color colorTitle;
  CustomAppbar(
      {this.title,
      this.enableBack = true,
      this.onBackTap,
      this.iconAction,
      this.onTapAction,
      this.backgroundColor,
      this.iconBack,
      this.colorTitle})
      : assert(enableBack != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor ?? Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).padding.top,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 13.0),
            child: Row(
              children: <Widget>[
                Opacity(
                  child: InkWell(
                    onTap: enableBack
                        ? onBackTap ??
                            () {
                              Navigator.of(context).pop();
                            }
                        : null,
                    child: Container(
                      width: 40,
                      height: 40,
                      padding: EdgeInsets.all(5.0),
                      margin: EdgeInsets.only(left: Globals.maxPadding),
                      child: Image.asset(
                        iconBack ?? icClose,
                        width: 30,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  opacity: enableBack ? 1.0 : 0.0,
                ),
                Container(
                  width: 5.0,
                ),
                Expanded(
                    child: Text(
                  title ?? "",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: colorTitle ?? Colors.black),
                  textAlign: TextAlign.center,
                  softWrap: true,
                )),
                Container(
                  width: 5.0,
                ),
                iconAction != null
                    ? Opacity(
                        opacity: 1.0,
                        child: InkWell(
                          child: Container(
                            width: 40,
                            height: 40,
                            padding: EdgeInsets.all(5.0),
                            margin: EdgeInsets.only(right: Globals.maxPadding),
                            child: Image.asset(
                              iconAction,
                              width: 30,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          onTap: iconAction == null ? null : onTapAction,
                        ),
                      )
                    : Container(width: 30,),
              ],
            ),
          ),
          Container(
            child: Divider(
              color: bigStone08Color,
              height: 1.0,
            ),
          )
        ],
      ),
    );
  }
}
