import 'package:Memory/blocs/ui_helper_bloc.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  HomePage({
    Key key,
  }) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final _homePageTabs = [
    Center(
        child: Text(
      "Memory Lane",
      style: TextStyle(fontSize: 48.0),
    )),
    Center(
        child: Text(
      "Today",
      style: TextStyle(fontSize: 48.0),
    )),
    Center(
        child: Text(
      "Your memory",
      style: TextStyle(fontSize: 48.0),
    )),
    Center(
        child: Text(
      "Search",
      style: TextStyle(fontSize: 48.0),
    )),
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Theme.of(context).brightness == Brightness.light
          ? Brightness.dark
          : Brightness.light,
      statusBarColor: uIHelperBloc.brightnessValue, // status bar color
    ));
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<int>(
            stream: uIHelperBloc.currentTabIndex,
            initialData: 0,
            builder: (context, snapshot) {
              _selectedIndex = snapshot.data;
              return _homePageTabs.elementAt(_selectedIndex);
            }),
        floatingActionButton: FloatingActionButton.extended(
            icon: Icon(Icons.swap_calls),
            label: Text("Switch theme"),
            onPressed: () {
              setState(() {
                switchBrightness();
              });
            }),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              BottomNavigationBarItem(
                icon: Icons.memory,
                title: "Memory Lane",
                index: 0,
              ),
              BottomNavigationBarItem(
                icon: Icons.today,
                title: "Today",
                index: 1,
              ),
              BottomNavigationBarItem(
                icon: Icons.cloud,
                title: "Your Memory",
                index: 2,
              ),
              BottomNavigationBarItem(
                icon: Icons.search,
                title: "Search",
                index: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  switchBrightness() {
    print(Theme.of(context).brightness.toString());

    if (Theme.of(context).brightness == Brightness.dark) {
      DynamicTheme.of(context).setBrightness(Brightness.light);
      // DynamicTheme.of(context).setThemeData(da)
      print("set as light");
    } else {
      DynamicTheme.of(context).setBrightness(Brightness.dark);
      print("set as dark");
    }
  }
}

class BottomNavigationBarItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final int index;

  const BottomNavigationBarItem({
    Key key,
    @required this.title,
    @required this.icon,
    @required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: kBottomNavigationBarHeight,
        child: InkWell(
          onTap: () {
            uIHelperBloc.setCurrentTab(index);
          },
          child: StreamBuilder<int>(
              initialData: 0,
              stream: uIHelperBloc.currentTabIndex,
              builder: (context, snapshot) {
                Color itemColor = snapshot.data == index
                    ? Colors.cyan
                    : Theme.of(context).iconTheme.color;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(
                      icon,
                      color: itemColor,
                    ),
                    Text(
                      title,
                      style: Theme.of(context).textTheme.overline.copyWith(
                            color: itemColor,
                          ),
                    )
                  ],
                );
              }),
        ),
      ),
    );
  }
}
