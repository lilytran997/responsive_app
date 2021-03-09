import 'package:flutter/material.dart';

class TabWidget {
  int id;
  final Widget icon;
  final Widget child;
  final String title;
  final String iconUrl;
  final Function onTap;
  final bool isDisable;
   bool isSelected;
  TabWidget(this.icon, this.child, this.title,this.onTap,{this.id,this.isDisable=false,this.isSelected=false,this.iconUrl});
}