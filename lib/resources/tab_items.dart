import 'package:flutter/material.dart';

class TabItem {
  final String title;
  final IconData iconData;

  TabItem({@required this.title, @required this.iconData});

  String get tabItemTitle => title;

  IconData get tabItemIcon => iconData;
}
