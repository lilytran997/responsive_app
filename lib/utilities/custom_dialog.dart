import 'package:demo_desktop/utilities/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {

  final Widget screen;
  final bool bottom;
  final bool cancelable;

  CustomDialog({
    @required this.screen,
    this.bottom = false,
    this.cancelable = true,
  }):assert(screen != null && cancelable != null);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: Globals.maxHeight,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              GestureDetector(
                onTap: cancelable?() =>  Navigator.of(context, rootNavigator: true).pop():null,
              ),
              Column(
                mainAxisAlignment: bottom?MainAxisAlignment.end:MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: Globals.maxPadding),
                    child: screen,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}