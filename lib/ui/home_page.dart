import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:memory/blocs/status_bar_color_bloc.dart';

class HomePage extends StatefulWidget {
  HomePage({
    Key key,
  }) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Theme.of(context).brightness == Brightness.light
          ? Brightness.dark
          : Brightness.light,
      // statusBarColor: Colors.grey[500], // status bar color
      statusBarColor: statusBarColorBloc.brightnessValue, // status bar color
    ));
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Memory',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.swap_calls),
          label: Text("Switch theme"),
          onPressed: () {
            setState(() {
              switchBrightness();
            });
          }),
    );
  }

  switchBrightness() {
    print(Theme.of(context).brightness.toString());

    if (Theme.of(context).brightness == Brightness.dark) {
      DynamicTheme.of(context).setBrightness(Brightness.light);
      // DynamicTheme.of(context).setThemeData(da)
      print("set as light");
    } else {
      DynamicTheme.of(context).setBrightness(Brightness.dark);
      print("set as dark");
    }
  }
}
