import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    ;
  }

  @override
  void dispose() {
    //This restores the status bar if the back button is pressed while the status bar is hidden
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Hero(
            tag: _imageUrl,
            child: GestureDetector(
              onTap: switchOverlayOpacity,
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
                backgroundColor: Colors.black.withOpacity(0.15),
                elevation: 0.0,
                iconTheme: Theme.of(context).iconTheme.copyWith(
                  color: Colors.white
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 500),
              opacity: _overlayOpacity,
              child: Container(
                color: Colors.black.withOpacity(0.20),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "4:20pm",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                      Text(
                        "Today",
                        style: Theme.of(context)
                            .textTheme
                            .headline
                            .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void switchOverlayOpacity() {
    setState(() {
      SystemChrome.setEnabledSystemUIOverlays([]);

      _overlayOpacity = _overlayOpacity == 0.0 ? 1.0 : 0.0;
      SystemChrome.setEnabledSystemUIOverlays(_overlayOpacity == 0.0
          ? [SystemUiOverlay.bottom]
          : [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    });
  }
}
