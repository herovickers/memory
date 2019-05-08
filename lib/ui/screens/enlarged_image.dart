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

  double _overlayOpacity;

  @override
  void initState() {
    super.initState();
    _imageUrl = widget.imageUrl;
    _overlayOpacity = 1.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Hero(
            tag: _imageUrl,
            child: GestureDetector(
              onLongPress: switchOverlayOpacity,
              onLongPressUp: switchOverlayOpacity,
              child: Container(
                  decoration: BoxDecoration(
                // color: Colors.blue
                image: DecorationImage(
                    image: AssetImage(_imageUrl), fit: BoxFit.cover),
              )),
            ),
          ),
          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 500),
              opacity: _overlayOpacity,
              child: AppBar(
                automaticallyImplyLeading: true,
                backgroundColor: Colors.black.withOpacity(0.05),
                elevation: 0.0,
              ),
            ),
          )
        ],
      ),
    );
  }

  void switchOverlayOpacity() {
    setState(() {
      _overlayOpacity = _overlayOpacity == 0.0 ? 1.0 : 0.0;
    });
  }
}
