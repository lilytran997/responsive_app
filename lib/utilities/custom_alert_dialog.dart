
import 'package:demo_desktop/utilities/check_platform.dart';
import 'package:demo_desktop/utilities/globals.dart';
import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final String contract;
  final CustomOptionDialog buttonLeft;
  final CustomOptionDialog buttonRight;
  final bool isRichText;
  final String iconCenter;
  final bool noIcon;
  CustomAlertDialog(
      {@required this.title,
      this.content,
      this.buttonLeft,
      this.buttonRight,
      this.isRichText,
      this.iconCenter,
      this.noIcon = false, this.contract});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
      child: Container(
          decoration: BoxDecoration(
              borderRadius: new BorderRadius.all(Radius.circular(8.0))),
          width: Globals.maxWidth,
          margin: noIcon?EdgeInsets.all(Globals.maxPadding):EdgeInsets.all(0),
          padding: EdgeInsets.symmetric(
              vertical: Globals.maxPadding, horizontal: Globals.maxPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
//            Row(
//              mainAxisAlignment: MainAxisAlignment.start,
//              children: [
//                InkWell(
//                  onTap: () {
//                    Navigator.of(context, rootNavigator: true).pop();
//                  },
//                  child: Container(
//                    height: 40.0,
//                    width: 40.0,
//                    child: Icon(Icons.close),
//                  ),
//                ),
//              ],
//            ),
              noIcon||iconCenter==null
                  ? Container(
                     height:  Globals.maxPadding,
                    )
                  : Center(
                      child: Container(
                        margin: EdgeInsets.only(bottom: Globals.maxPadding),
                        height: Globals.maxWidth / 5,
                        width: Globals.maxWidth / 5,
                        alignment: Alignment.center,
                        child: Image.asset(iconCenter),
                      ),
                    ),
              Padding(
                padding: EdgeInsets.only(bottom: Globals.maxPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            color: HexColor("22313F")),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: Globals.maxPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: isRichText
                          ? RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(children: [
                                TextSpan(
                                    text: content,
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black)),
                                TextSpan(
                                    text: contract,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14)),
                                TextSpan(
                                    text: ' không?',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black))
                              ]))
                          : Text(
                              content,
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                              // maxLines: 2,
                              // overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                    ),
                  ],
                ),
              ),
              Container(height:Globals.maxPadding ,),
              Row(
                children: [
                  Expanded(
                      child: InkWell(
                    onTap: () {
                      if (buttonLeft == null || buttonLeft.onTap == null) {
                        Navigator.of(context, rootNavigator: true).pop();
                      } else {
                        buttonLeft.onTap();
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 5.0),
//                                        height: 40.0,
                      padding: EdgeInsets.only(
                          top: Globals.minPadding, bottom: Globals.minPadding),
                      decoration: BoxDecoration(
                        color:  buttonLeft?.colorLabel ?? (buttonRight == null ? Colors.blue :Colors.white),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Center(
                        child: Text(
                          buttonLeft?.title ?? (buttonRight == null
                              ? "Đóng"
                              : "Hủy"),
                          style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                              color: buttonLeft?.colorText ??(buttonRight == null
                                  ? Colors.white
                                  : Colors.blue) ),
                        ),
                      ),
                    ),
                  )),
                  buttonRight == null
                      ? Container()
                      : Expanded(
                          child: InkWell(
                          onTap: () {
                            if (buttonRight.onTap != null) {
                              buttonRight.onTap();
                            } else {
                              Navigator.of(context, rootNavigator: true).pop();
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 5.0),
//                                        height: 40.0,
                            padding: EdgeInsets.only(
                                top: Globals.minPadding,
                                bottom: Globals.minPadding),
                            decoration: BoxDecoration(
                              color: buttonRight?.colorLabel ?? Colors.blue,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Center(
                              child: Text(
                                buttonRight?.title ?? "Xác nhận",
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600,
                                    color:
                                        buttonRight?.colorText ?? Colors.white),
                              ),
                            ),
                          ),
                        ))
                ],
              )
            ],
          )),
    );
  }
}
class CustomOptionDialog {
  final String title;
  final Color colorLabel;
  final Function onTap;
  final Color colorText;
  CustomOptionDialog(this.title, this.colorLabel, this.onTap, this.colorText);
}