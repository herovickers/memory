import 'dart:math';

import 'package:Memory/resources/avatar_shadow_colors.dart';
import 'package:Memory/resources/dummy_data.dart';
import 'package:Memory/ui/screens/details_screen.dart';
import 'package:flutter/material.dart';

class MemoryLane extends StatefulWidget {
  const MemoryLane({
    Key key,
  }) : super(key: key);

  @override
  _MemoryLaneState createState() => _MemoryLaneState();
}

class _MemoryLaneState extends State<MemoryLane>
    with SingleTickerProviderStateMixin {
//TODO Replace dummy data with real data
//TODO Set max list items as 10

  var dummyItemList = DummyData.dummyItemList;
  var dummyUserNameList = DummyData.dummyUserNameList;
  var dummyUserAliasList = DummyData.dummyUserAliasList;
  var dummyImageAssetLocationList = DummyData.dummyImageAssetLocationList;
  var dummyList = DummyData.dummyList;
  var dummyTimestampList = DummyData.dummyTimestampList;
  var random = Random();

  @override
  Widget build(BuildContext context) {
    ThemeData currentTheme = Theme.of(context);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    var aspectRatio = screenWidth / screenHeight;
    double memoryItemheight =
        (screenHeight - kBottomNavigationBarHeight - kToolbarHeight) * 2 / 3;
    Color avatarShadowColor = currentTheme.brightness == Brightness.dark
        ? AvatarShadowColor.darkAvatarShadowColor
        : AvatarShadowColor.lightAvatarShadowColor;

    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          // color: Colors.blue,
          height: memoryItemheight,
          margin: EdgeInsets.only(
              top: index == 0 ? 16.0 : 0.0,
              bottom: index == (dummyItemList.length - 1) ? 16.0 : 0.0,
              left: 16.0,
              right: 16.0),
          child: Column(
            children: <Widget>[
              ListTile(
                leading: Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: avatarShadowColor,
                        offset: new Offset(0.0, 0.0),
                        blurRadius: 10.0,
                        spreadRadius: 0.0),
                  ]),
                  child: CircleAvatar(
                    backgroundImage: AssetImage(
                        dummyImageAssetLocationList.elementAt(index)),
                  ),
                ),
                title: Text(
                  dummyUserAliasList.elementAt(index),
                  style: Theme.of(context).textTheme.title,
                ),
                subtitle: Text("@" + dummyUserNameList.elementAt(index)),
                trailing: Text(dummyTimestampList.elementAt(index)),
              ),
              Expanded(
                child: Align(
                  alignment:
                      Alignment(((1 - dummyItemList.length) / 10.0), 0.0),
                  child: Container(
                    //The container needs a width so the Align widget can work.
                    width: screenWidth / 2,
                    child: Stack(
                      overflow: Overflow.visible,
                      children: dummyItemList.map((f) {
                        int index2 = dummyItemList.indexOf(f);
                        final dummyImageAssetLocation =
                            dummyImageAssetLocationList.elementAt(index2);
                        return GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => DetailsScreen())),
                          child: Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.identity()
                              ..translate(0.0, 0.0, 0.0)
                              ..translate(
                                  dummyItemList.length == 1
                                      ? 0.0
                                      : index2 * 10.0,
                                  0.0,
                                  0.0)
                              ..scale(1.0, ((index2 + 1) / dummyItemList.length)
                                  // (index + 1) * 8.9 / (9 * itemLength),
                                  ),
                            child: Align(
                              alignment: Alignment.center,
                              child: AspectRatio(
                                aspectRatio: aspectRatio,
                                child: Container(
                                  child: Center(
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
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade300,
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: AssetImage(
                                                      dummyImageAssetLocation))),
                                        )
                                        //     Image.asset(

                                        //   dmmmyImageAssetLocationRandom,
                                        // ),
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      itemCount: dummyList.length,
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          color: Colors.grey,
        );
      },
    );
  }
}
