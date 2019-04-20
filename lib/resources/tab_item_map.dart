import 'package:Memory/resources/tab_items.dart';
import 'package:flutter/material.dart';

class TabItemMap {
  static Map<String, TabItem> tabItemMap = {
    "MemoryLane": TabItem(title: "Memory Lane", iconData: Icons.timeline),
    "Today": TabItem(title: "Today", iconData: Icons.timelapse),
    "YourMemories": TabItem(title: "Your memories", iconData: Icons.cloud),
    "Search": TabItem(title: "Search", iconData: Icons.search)
  };
}
