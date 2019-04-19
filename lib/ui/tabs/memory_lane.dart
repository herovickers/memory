import 'package:flutter/material.dart';

class MemoryLane extends StatelessWidget {
  const MemoryLane({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double memoryItemheight =
        (screenHeight - kBottomNavigationBarHeight - kToolbarHeight) / 2;

    return Container(
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: memoryItemheight,
            //TODO: Remove hard coded item count in itemCount property and margin
            margin: EdgeInsets.only(
                top: index == 0 ? 16.0 : 0.0, bottom: index == 5 ? 16.0 : 0.0),
            child: Center(
              child: ListTile(
                title: Container(
                    color: Colors.lightBlue,
                    child: Center(child: Icon(Icons.timeline))),
              ),
            ),
          );
        },
        itemCount: 6,
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
      ),
    );
  }
}
