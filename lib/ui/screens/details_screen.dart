import 'package:Memory/resources/dummy_data.dart';
import 'package:Memory/ui/screens/enlarged_image.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  var dummyItemList = DummyData.dummyItemList;
  var dummyImageAssetLocationList = DummyData.dummyImageAssetLocationList;

  @override
  void initState() {
    super.initState();
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
              child: AspectRatio(
                aspectRatio: aspectRatio,
                child: Align(
                  alignment:
                      Alignment(((1 - dummyItemList.length) / 10.0), 0.0),
                  child: Stack(
                      overflow: Overflow.visible,
                      children: dummyItemList.map((f) {
                        int index = dummyItemList.indexOf(f);
                        final dummyImageAssetLocation =
                            dummyImageAssetLocationList.elementAt(index);
                        return GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => EnlargedImage(
                                      imageUrl: dummyImageAssetLocation))),
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
                          //TODO add hero
                          child: Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.identity()
                              ..translate(0.0, 0.0, 0.0)
                              ..translate(
                                  dummyItemList.length == 1 ? 0.0 : index * 6.0,
                                  0.0,
                                  0.0)
                              ..scale(1.0, ((index + 1) / dummyItemList.length)
                                  // (index + 1) * 8.9 / (9 * itemLength),
                                  ),
                            child: Card(
                              elevation: 5.0,
                              clipBehavior: Clip.antiAlias,
                              shape: RoundedRectangleBorder(
                                //TODO Change border color
                                side:
                                    BorderSide(width: 0.2, color: Colors.white),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Container(
                                  decoration: BoxDecoration(
                                // color: Colors.blue
                                image: DecorationImage(
                                    image: AssetImage(dummyImageAssetLocation),
                                    fit: BoxFit.cover),
                              )),
                            ),
                          ),
                        );
                      }).toList()),
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
