import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({
    Key key,
  }) : super(key: key);

  @override
  SearchState createState() => SearchState();
}

class SearchState extends State<Search> {
  openSearch() {
    showSearch(context: context, delegate: MemorySearchDelegate());
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
          showSearch(context: context, delegate: MemorySearchDelegate());
        },
          )
        ],
      ),
      body: Center(
          child: Text(
            "Search",
            style: TextStyle(fontSize: 48.0),
          )),
    );
  }
}

class MemorySearchDelegate extends SearchDelegate {

    @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme;
  }


  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(child: Text("Search Results"));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // This method is called everytime the search term changes.
    // If you want to add search suggestions as the user enters their search term, this is the place to do that.
    return Center(
      child: Column(
        children: <Widget>[
          Text("Searching for your input"),
          SizedBox(
            height: 42.0,
          ),
          Center(
            child: CircularProgressIndicator(),
          )
        ],
      ),
    );
  }
}
