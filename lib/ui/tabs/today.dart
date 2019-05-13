import 'package:flutter/material.dart';

class Today extends StatelessWidget {
  const Today({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Today"),
      ),
          body: Center(
          child: Text(
        "Today",
        style: TextStyle(fontSize: 48.0),
      )),
    );
  }
}