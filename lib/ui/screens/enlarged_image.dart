import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EnlargedImage extends StatefulWidget {
  final heroTag;
  // final imageUrl;

  EnlargedImage({
    @required this.heroTag,
    // @required this.imageUrl,
  });

  @override
  _EnlargedImageState createState() => _EnlargedImageState();
}

class _EnlargedImageState extends State<EnlargedImage> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.heroTag,
      child: Container(
          decoration: BoxDecoration(color: Colors.blue
              // image: DecorationImage(
              //     image: NetworkImage(widget.imageUrl), fit: BoxFit.cover),
              )),
    );
  }
}
