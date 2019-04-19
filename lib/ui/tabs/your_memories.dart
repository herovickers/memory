import 'package:flutter/material.dart';

class YourMemories extends StatelessWidget {
  const YourMemories({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      "Your memories",
      style: TextStyle(fontSize: 48.0),
    ));
  }
}
