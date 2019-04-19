// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:Memory/resources/tab_item_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Test that tab item map exists', () {
    expect(TabItemMap.TAB_ITEM_MAP, isNotNull);
  });

  test('Test that the third tab item map value title [TabItemMap.TAB_ITEM_MAP.values.toList()[2 ] returns "Your memories" ', (){
    expect(TabItemMap.TAB_ITEM_MAP.values.toList()[2].tabItemTitle, "Your memories");
  });
}
