import 'package:Memory/ui/screens/enlarged_image.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  final heroTag;

  DetailsScreen({
    @required this.heroTag,
  });

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    var aspectRatio = screenWidth / screenHeight;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: Container(),
          ),
          Expanded(
            flex: 3,
            child: Center(
              child: AspectRatio(
                aspectRatio: aspectRatio,
                child: GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => EnlargedImage(
                                heroTag: widget.heroTag,
                              ))),
                  onHorizontalDragStart: ((dragStartDetails) {
                    print("dragStarrtDetails");
                    print(dragStartDetails.globalPosition);
                  }),
                  onHorizontalDragEnd: ((dragEndDetails) {
                    print("dragEndDetails");
                    print(dragEndDetails.toString());
                  }),
                  onHorizontalDragUpdate: ((dragUpdateDetails) {
                    print("dragUpdateDetails");
                    print(dragUpdateDetails.delta);
                  }),
                  child: Hero(
                    tag: widget.heroTag,
                    child: Card(
                      elevation: 5.0,
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        //TODO Change border color
                        side: BorderSide(width: 0.2, color: Colors.white),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Container(
                          decoration: BoxDecoration(color: Colors.blue
                              // image: DecorationImage(
                              //     image: NetworkImage(widget.imageUrl), fit: BoxFit.cover),
                              )),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: kBottomNavigationBarHeight,
          ),
        ],
      ),
    );
  }
}
