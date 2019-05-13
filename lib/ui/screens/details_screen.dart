import 'package:Memory/resources/dummy_data.dart';
import 'package:Memory/ui/screens/enlarged_image.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  final List imageUrlList;

  const DetailsScreen({Key key, @required this.imageUrlList}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen>
    with SingleTickerProviderStateMixin {
  List imageUrlList;
  List imageUrlListCopy;
  List imageUrlListRemoved;
  Animation<double> _scaleAnimation;
  Animation _translateAnimation;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    imageUrlList = widget.imageUrlList;
    imageUrlListCopy = imageUrlList;
    imageUrlListRemoved = [];

    _animationController = AnimationController(
        duration: Duration(
          milliseconds: 500,
        ),
        vsync: this);
    _scaleAnimation = Tween(begin: 1.0, end: 1.5).animate(CurvedAnimation(
        curve: Curves.easeIn,
        reverseCurve: Curves.easeOut,
        parent: _animationController))
      ..addListener(() {
        //TODO Use an animated builder instead of setState
        setState(() {});
      });

    Future.delayed(Duration.zero, () {
      _translateAnimation =
          Tween(begin: 1.0, end: MediaQuery.of(context).size.width).animate(
              CurvedAnimation(
                  curve: Curves.easeIn,
                  reverseCurve: Curves.easeOut,
                  parent: _animationController))
            ..addListener(() {
              //TODO Use an animated builder instead of setState
              setState(() {});
            });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    //TODO fix this issue with details screen mutating memory lane
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    var aspectRatio = screenWidth / screenHeight;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          elevation: 0.0,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: Text("4:20pm"),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Flexible(
                      child: Text(
                        "Today",
                        style: Theme.of(context)
                            .textTheme
                            .headline
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: GestureDetector(
                onHorizontalDragUpdate: ((dragUpdateDetails) {
                  if (dragUpdateDetails.delta.dx > 0.0 &&
                      !_animationController.isAnimating &&
                      imageUrlListCopy.length != 1) {
                    _animationController.reset();

                    _animationController.forward().whenComplete(() {
                      setState(() {
                        imageUrlListRemoved.add(imageUrlListCopy.removeLast());
                      });
                    });
                  } else if (dragUpdateDetails.delta.dx < 0.0 &&
                      !_animationController.isAnimating &&
                      imageUrlListRemoved.isNotEmpty) {
                    setState(() {
                      imageUrlListCopy.add(imageUrlListRemoved.removeLast());
                    });

                    _animationController.animateTo(0).whenComplete(() {
                      _animationController.value = 1.0;
                    });
                  }
                }),
                child: Center(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: AspectRatio(
                      aspectRatio: aspectRatio,
                      child: Container(
                        // color: Colors.amber,
                        child: Align(
                          alignment: Alignment(
                              ((1 - imageUrlListCopy.length) / 10.0), 0.0),
                          child: Stack(
                              overflow: Overflow.visible,
                              children: imageUrlListCopy.map((f) {
                                int index = imageUrlList.indexOf(f);
                                final dummyImageAssetLocation =
                                    imageUrlList.elementAt(index);
                                return GestureDetector(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => EnlargedImage(
                                              imageUrl:
                                                  dummyImageAssetLocation))),

                                  //TODO add hero
                                  child: Transform(
                                    alignment: Alignment.center,
                                    transform: Matrix4.identity()
                                      ..translate(
                                          (index == imageUrlList.length - 1
                                              ? (MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      6) +
                                                  (_translateAnimation == null
                                                      ? 0.0
                                                      : _animationController
                                                              .isCompleted
                                                          ? 0.0
                                                          : _translateAnimation
                                                              .value)
                                              : (((index + 1) /
                                                      imageUrlList.length) *
                                                  MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  6)),
                                          0.0)
                                      ..scale(
                                          1.0,
                                          ((index + 1) / imageUrlList.length) *
                                              (index == imageUrlList.length - 1
                                                  ? _animationController
                                                          .isCompleted
                                                      ? 1.0
                                                      : _scaleAnimation.value
                                                  : 1.0)
                                          // (index + 1) * 8.9 / (9 * itemLength),
                                          ),
                                    child: Card(
                                      elevation: 5.0,
                                      clipBehavior: Clip.antiAlias,
                                      shape: RoundedRectangleBorder(
                                        //TODO Change border color
                                        side: BorderSide(
                                            width: 0.2, color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: Container(
                                          // child: Center(
                                          //     child: Text(
                                          //   index.toString(),
                                          //   style:
                                          //       Theme.of(context).textTheme.title,
                                          // )),
                                          decoration: BoxDecoration(
                                        // color: Colors.blue

                                        image: DecorationImage(
                                            image: AssetImage(
                                                dummyImageAssetLocation),
                                            fit: BoxFit.cover),
                                      )),
                                    ),
                                  ),
                                );
                              }).toList()),
                        ),
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
      ),
    );
  }
}
