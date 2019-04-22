import 'package:flutter/material.dart';

class EnlargedImage extends StatelessWidget {
  final tag;

  EnlargedImage({@required this.tag});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      child: Container(color: Colors.red),
    );
  }
}
