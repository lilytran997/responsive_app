import 'package:flutter/material.dart';

class TabWidget {
  final Widget icon;
  final Widget child;
  final String title;
  final Function onTap;
  final bool isDisable;
  TabWidget(this.icon, this.child, this.title,this.onTap,{this.isDisable=false});
}