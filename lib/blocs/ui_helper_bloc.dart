import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class UIHelperBloc {
  final statusBarColor = BehaviorSubject<Color>();
  final currentTabIndex = BehaviorSubject<int>();

  void dispose() {
    statusBarColor.close();
    currentTabIndex.close();
  }

  get brightnessValue {
    return statusBarColor.value;
  }

  setBrightness(Color color) {
    statusBarColor.sink.add(color);
  }

  setCurrentTab(int index) {
    currentTabIndex.sink.add(index);
  }
}

final uIHelperBloc = UIHelperBloc();
