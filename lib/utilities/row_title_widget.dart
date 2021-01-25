
import 'package:demo_desktop/common/constant.dart';
import 'package:demo_desktop/utilities/custom_line.dart';
import 'package:demo_desktop/utilities/globals.dart';
import 'package:flutter/material.dart';

class RenderRowTitleWidget extends StatelessWidget {
  final String title;
  final TextStyle style;
  final Widget suffixChild;
//  final Widget actionChild;
  final bool isRequired;
  final bool isForm;
  final Color colorBackground;
  final EdgeInsetsGeometry padding;
  const RenderRowTitleWidget(this.title, this.style,
      {Key key,
      this.suffixChild,
      this.isForm = false,
//      this.actionChild,
      this.colorBackground,
      this.padding,
      this.isRequired = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorBackground ?? Colors.transparent,
      padding: EdgeInsets.symmetric(horizontal: Globals.maxPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: padding ?? EdgeInsets.symmetric(vertical: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: isRequired
                      ? RichText(
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          textScaleFactor: 1,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(children: [
                            TextSpan(text: title, style: style),
                            TextSpan(
                                text: " *",
                                style: TextStyle(
                                    color: radicalRedColor,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14)),
                          ]))
                      : Text(
                          title,
                          style: style,
                          textScaleFactor: 1,
                        )
                ),
                Container(width: 10.0,),
                suffixChild ?? Container()
              ],
            ),
          ),
          isForm ? CustomLine() : Container()
        ],
      ),
    );
  }
}
