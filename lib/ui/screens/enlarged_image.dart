import 'package:flutter/material.dart';

class EnlargedImage extends StatefulWidget {
  final imageUrl;

  EnlargedImage({
    @required this.imageUrl,
    // @required this.imageUrl,
  });

  @override
  _EnlargedImageState createState() => _EnlargedImageState();
}

class _EnlargedImageState extends State<EnlargedImage> {
  String _imageUrl;

  @override
  void initState() {
    super.initState();
    _imageUrl = widget.imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Hero(
            tag: _imageUrl,
            child: Container(
                decoration: BoxDecoration(
              // color: Colors.blue
              image: DecorationImage(
                  image: AssetImage(_imageUrl), fit: BoxFit.cover),
            )),
          ),
          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: AppBar(
              automaticallyImplyLeading: true,
              backgroundColor: Colors.black.withOpacity(0.05),
              elevation: 0.0,
            ),
          )
        ],
      ),
    );
  }
}
