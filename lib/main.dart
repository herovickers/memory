import 'package:Memory/blocs/ui_helper_bloc.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Memory/ui/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    ThemeData lightThemeData = ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.grey,
        primaryColor: Colors.grey[50],
        // textTheme: theme.textTheme.copyWith(
        //   headline: theme.textTheme.headline.copyWith(
        //     color: Colors.black,
        //   ),
        //   display1: theme.textTheme.headline.copyWith(
        //     color: Colors.black38,
        //   ),
        //   //This is just title with another color
        //   display2: theme.textTheme.title.copyWith(
        //     color: Colors.black54,
        //   ),
        //   display3: theme.textTheme.title.copyWith(
        //     color: Colors.black87,
        //   ),
        //   caption: theme.textTheme.caption.copyWith(color: Colors.black38),
        //   button: theme.textTheme.button.copyWith(color: Colors.black),
        //   subhead: theme.textTheme.subhead.copyWith(color: Colors.black38),
        //   subtitle: theme.textTheme.subtitle.copyWith(color: Colors.black38),
        // ),
        primaryIconTheme:
            theme.primaryIconTheme.copyWith(color: Colors.cyan[600]),
        accentIconTheme:
            theme.primaryIconTheme.copyWith(color: Colors.grey[500]));

    ThemeData darkThemeData = ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.grey[850],

        // primarySwatch: Colors.grey[850],
        // textTheme: theme.textTheme.copyWith(
        //   headline: theme.textTheme.headline.copyWith(
        //     color: Colors.white,
        //   ),
        //   display1: theme.textTheme.headline.copyWith(
        //     color: Colors.white30,
        //   ),
        //   //This is just title with another color
        //   display2: theme.textTheme.title.copyWith(
        //     color: Colors.white54,
        //   ),

        //   display3: theme.textTheme.title.copyWith(
        //     color: Colors.white70,
        //   ),
        //   caption: theme.textTheme.caption.copyWith(color: Colors.white30),
        //   button: theme.textTheme.button.copyWith(color: Colors.white),
        //   subhead: theme.textTheme.subhead.copyWith(color: Colors.white30),
        //   subtitle: theme.textTheme.subtitle.copyWith(color: Colors.white30),
        // ),
        primaryIconTheme:
            theme.primaryIconTheme.copyWith(color: Colors.cyanAccent),
        accentIconTheme:
            theme.primaryIconTheme.copyWith(color: Colors.white70));

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return DynamicTheme(
        defaultBrightness: Brightness.light,
        data: (brightness) =>
            returnCurrentTheme(brightness, darkThemeData, lightThemeData),
        themedWidgetBuilder: (context, theme) {
          return MaterialApp(
            title: 'Memory',
            debugShowCheckedModeBanner: false,
            theme: theme,
            home: HomePage(),
          );
        });
  }

  ThemeData returnCurrentTheme(Brightness brightness, ThemeData darkThemeData,
      ThemeData lightThemeData) {
    if (brightness == Brightness.dark) {
      uIHelperBloc.setBrightness(darkThemeData.primaryColor);

      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: uIHelperBloc.brightnessValue, // status bar color
        ),
      );
      return darkThemeData;
    } else {
      uIHelperBloc.setBrightness(lightThemeData.primaryColor);

      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarColor: uIHelperBloc.brightnessValue, // status bar color
      ));

      return lightThemeData;
    }
  }
}
