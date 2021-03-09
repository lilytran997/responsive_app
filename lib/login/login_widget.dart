import 'package:demo_desktop/common/constant.dart';
import 'package:demo_desktop/utilities/check_platform.dart';
import 'package:demo_desktop/utilities/custom_navigator.dart';
import 'package:demo_desktop/utilities/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:universal_html/html.dart' as html;
import 'package:universal_html/prefer_universal/js.dart' as js;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  FocusNode _emailNode = FocusNode();
  FocusNode _passwordNode = FocusNode();
  String _platform = "";
  @override
  void initState() {
    // TODO: implement initState
    if (ApplicationPlatform.isAndroid) {
      _platform = "Mobisale";
    } else if (ApplicationPlatform.isIOS) {
      _platform = "Mobisale";
    } else if (ApplicationPlatform.isLinux) {
      _platform = "Appsale";
    } else if (ApplicationPlatform.isMacOS) {
      _platform = "Appsale";
    } else if (ApplicationPlatform.isWindows) {
      _platform = "Appsale";
    } else if (ApplicationPlatform.isWeb) {
      _platform = "Websale";
      if (js.context['state'] != null) {
        var state = js.JsObject.fromBrowserObject(js.context['state']);
        if (state['currentToken'] != null) {
          print("currentToken from dart: " + state['currentToken'].toString());
        }
        if (state['body'] != null) {
          print("body notification from dart: " + state['body'].toString());
        }
        if (state['title'] != null) {
          print("title notification from dart: " + state['title'].toString());
        }
      }
    } else {
      _platform = "undefined platform";
    }
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Widget _inputItem(String title, TextEditingController controller,
      FocusNode node, FocusNode nextNode, bool isRequire, bool isHide,
      {bool isPhone = false, String hint = ""}) {
    return Container(
      padding: EdgeInsets.only(
        right: Globals.maxPadding,
        left: Globals.maxPadding,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title != null
              ? Container(
                  margin: EdgeInsets.only(
                    top: Globals.minPadding,
                  ),
                  child: RichText(
                    text: TextSpan(
                        text: title ?? "",
                        style: TextStyle(color: Colors.black, fontSize: 15.0),
                        children: [
                          TextSpan(
                            text: isRequire ? "*" : "",
                            style: TextStyle(color: Colors.red, fontSize: 15.0),
                          ),
                        ]),
                  ),
                )
              : Container(),
          Container(
            margin: EdgeInsets.only(
              top: Globals.minPadding,
            ),
            // padding: EdgeInsets.only(left: 16.0, right: 16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              border:
                  Border.all(color: node.hasFocus ? primaryColor : Colors.grey),
            ),
            child: TextField(
              style: TextStyle(color: Colors.black, fontSize: 14),
              controller: controller,
              focusNode: node,
              keyboardType: isPhone ? TextInputType.number : TextInputType.text,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                ),
                filled: true,
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                suffixIcon: isPhone
                    ? null
                    : Container(
                        margin: EdgeInsets.only(
                          right: Globals.minPadding,
                          left: Globals.minPadding,
                        ),
                        child: isHide
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                      ),
              ),
              onSubmitted: (value) {},
              onChanged: (value) {},
            ),
          )
        ],
      ),
    );
  }

  ///bootstrap
  ///xs for extra small screens < 576px
  /// sm for small screens > 575px and < 768px
  /// md for medium screens > 767px and < 992px
  /// lg for large screens > 991px and < 1200px
  ///xl for extra large screens > 1199px
  ///document: https://www.didierboelens.com/2020/05/responsive-bootstrap-like-solution/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BootstrapContainer(
                  fluid: true,
                  padding: EdgeInsets.only(
                      left: Globals.maxPadding,
                      right: Globals.maxPadding,
                      top: Globals.maxPadding + Globals.statusBarHeight),
                  children: [
                    BootstrapRow(
                      height: Globals.maxHeight * 0.4,
                      children: <BootstrapCol>[
                        BootstrapCol(
                          sizes: 'col-xs-12 col-sm-12 col-md-6 col-lg-6 col-xl-6',
                          orders:
                              'order-1 order-sm-1 order-md-1 order-lg-1 order-xl-1',
                          child: Container(
                            alignment: Alignment.center,
                            height: Globals.maxHeight * 0.4,
                            margin: EdgeInsets.only(bottom: Globals.maxPadding),
                            child: Image.asset("assets/login_background.png"),
                          ),
                        ),
                        BootstrapCol(
                          sizes: 'col-xs-12 col-sm-12 col-md-6 col-lg-6 col-xl-6',
                          orders:
                              'order-2 order-sm-2 order-md-2 order-lg-2 order-xl-2',
                          child: BootstrapContainer(
                            fluid: true,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(
                                      top: Globals.maxPadding,
                                      bottom: Globals.minPadding),
                                  alignment: Alignment.center,
                                  child: SelectableText(_platform ?? "",
                                      showCursor: false,
                                      textAlign: TextAlign.center,
                                      toolbarOptions: ToolbarOptions(
                                          copy: true,
                                          selectAll: true,
                                          cut: false,
                                          paste: false),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: Globals.maxPadding,
                                        fontWeight: FontWeight.w600,
                                      ))),
                              _inputItem(null, _emailController, _emailNode,
                                  _passwordNode, true, false,
                                  isPhone: true, hint: "Tên đăng nhập"),
                              _inputItem(null, _passwordController, _passwordNode,
                                  null, true, true,
                                  hint: "Mật khẩu"),
                              InkWell(
                                onTap: () {
                                  if (ApplicationPlatform.isWeb) {
                                    String username =
                                        Globals.prefs.getString("KEY_TEST");
                                    if (username != null) {
                                      html.window.localStorage.remove('username');
                                    }
                                    html.window.sessionStorage['username'] =
                                        "TEST LOCAL STORAGE";
                                  } else {
                                    Globals.prefs.setString(
                                        "KEY_TEST", "TEST LOCAL STORAGE");
                                  }
                                  CustomNavigator().pushNamedAndRemoveUntil(
                                    context,
                                    "/HomePage",
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                    top: Globals.minPadding,
                                    bottom: Globals.minPadding,
                                    right: Globals.maxPadding,
                                    left: Globals.maxPadding,
                                  ),
                                  width: Globals.maxWidth,
                                  height: 44.0,
                                  decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(8.0)),
                                  child: Center(
                                    child: Text(
                                      "Đăng nhập",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // BootstrapRow(
                    //   height: Globals.maxHeight*0.6,
                    //   children: <BootstrapCol>[
                    //     BootstrapCol(
                    //       offsets: 'offset-0 offset-sm-1 offset-md-2 offset-lg-3 offset-xl-4',
                    //       child:  Container(
                    //           margin: EdgeInsets.only(
                    //               top: Globals.maxPadding, bottom: Globals.minPadding),
                    //           child:  SelectableText( _platform??"",
                    //               cursorColor: Colors.red,
                    //               showCursor: false,
                    //               textAlign: TextAlign.center,
                    //               toolbarOptions: ToolbarOptions(
                    //                   copy: true,
                    //                   selectAll: true,
                    //                   cut: false,
                    //                   paste: false
                    //               ),
                    //               style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600,))
                    //
                    //         // Text(
                    //         //   _platform??"",
                    //         //   style: TextStyle(
                    //         //       fontSize: Globals.maxPadding,
                    //         //       fontWeight: FontWeight.w600,
                    //         //       color: Colors.black),
                    //         //   textAlign: TextAlign.center,
                    //         // )
                    //       ),
                    //     ),
                    //     BootstrapCol(
                    //       offsets: 'offset-0 offset-sm-1 offset-md-2 offset-lg-3 offset-xl-4',
                    //       child: _inputItem(
                    //           null, _emailController, _emailNode, _passwordNode, true, false,
                    //           isPhone: true, hint: "Tên đăng nhập"),
                    //     ),
                    //     BootstrapCol(
                    //       offsets: 'offset-0 offset-sm-1 offset-md-2 offset-lg-3 offset-xl-4',
                    //       child: _inputItem(
                    //           null, _passwordController, _passwordNode, null, true, true,
                    //           hint: "Mật khẩu"),
                    //     ),
                    //     BootstrapCol(
                    //       offsets: 'offset-0 offset-sm-1 offset-md-2 offset-lg-3 offset-xl-4',
                    //       child: InkWell(
                    //         onTap: () {
                    //           if(ApplicationPlatform.isWeb){
                    //             String username = Globals.prefs.getString("KEY_TEST");
                    //             if (username != null) {
                    //               html.window.localStorage.remove('username');
                    //             }
                    //             html.window.sessionStorage['username'] = "TEST LOCAL STORAGE";
                    //           }else{
                    //             Globals.prefs.setString("KEY_TEST", "TEST LOCAL STORAGE");
                    //           }
                    //           CustomNavigator().pushNamedAndRemoveUntil(
                    //             context,
                    //             "/HomePage",
                    //           );
                    //         },
                    //         child: Container(
                    //           margin: EdgeInsets.only(
                    //             top: Globals.minPadding,
                    //             bottom: Globals.minPadding,
                    //             right: Globals.maxPadding,
                    //             left: Globals.maxPadding,
                    //           ),
                    //           width: Globals.maxWidth,
                    //           height: 44.0,
                    //           decoration: BoxDecoration(
                    //               color: primaryColor,
                    //               borderRadius: BorderRadius.circular(8.0)),
                    //           child: Center(
                    //             child: Text(
                    //               "Đăng nhập",
                    //               style: TextStyle(
                    //                   color: Colors.white,
                    //                   fontSize: 14.0,
                    //                   fontWeight: FontWeight.w600),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ],
            ),
          ),
        )
        // ResponsiveWidget(
        //   largeScreen: LoginDesktop(
        //     childRight: _renderBody(),
        //   ),
        //   mediumScreen: LoginDesktop(
        //     childRight: _renderBody(),
        //   ),
        //   smallScreen: _renderBody(),
        // ),
        );
  }
}
