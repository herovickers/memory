import 'package:Memory/blocs/ui_helper_bloc.dart';
import 'package:Memory/resources/tab_item_map.dart';
import 'package:Memory/resources/tab_items.dart';
import 'package:Memory/ui/tabs/memory_lane.dart';
import 'package:Memory/ui/tabs/search.dart';
import 'package:Memory/ui/tabs/today.dart';
import 'package:Memory/ui/tabs/your_memories.dart';
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
  List<String> tabBarItemKeysList = TabItemMap.tabItemMap.keys.toList();
  List<TabItem> tabBarItemValuesList = TabItemMap.tabItemMap.values.toList();

  final _homePageTabs = [
    MemoryLane(),
    Today(),
    YourMemories(),
    Search(),
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
      child: StreamBuilder<Object>(
          stream: uIHelperBloc.currentTabIndex,
          initialData: 0,
          builder: (context, snapshot) {
            _selectedIndex = snapshot.data;
            return Scaffold(
              body: _homePageTabs.elementAt(_selectedIndex),
              floatingActionButton: Opacity(
                child: FloatingActionButton(
                    child: Icon(
                      Icons.swap_calls,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        switchBrightness();
                      });
                    }),
                opacity: 1.0,
              ),
              bottomNavigationBar: BottomAppBar(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: tabBarItemKeysList.map((tab) {
                    var tabIndex = tabBarItemKeysList.indexOf(tab);
                    return BottomNavigationBarItem(
                      icon: tabBarItemValuesList[tabIndex].tabItemIcon,
                      title: tabBarItemValuesList[tabIndex].tabItemTitle,
                      index: tabIndex,
                    );
                  }).toList(),
                ),
              ),
            );
          }),
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
                    ? Theme.of(context).primaryIconTheme.color
                    : Theme.of(context).accentIconTheme.color;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(
                      icon,
                      color: itemColor,
                    ),
                    Text(
                      title,
                      style: Theme.of(context).textTheme.caption.copyWith(
                          color: itemColor, fontWeight: FontWeight.w500),
                    )
                  ],
                );
              }),
        ),
      ),
    );
  }
}
