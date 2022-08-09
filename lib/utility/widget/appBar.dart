import 'package:flutter/material.dart';

class WWAppBar extends StatefulWidget {
  final String title;
  final Color? color;
  final Color? backgroundColor;

  const WWAppBar({
    Key? key,
    required this.title,
    this.color,
    this.backgroundColor,
  }) : super(key: key);

  @override
  State<WWAppBar> createState() => _WWAppBarState();
}

class _WWAppBarState extends State<WWAppBar> {
  bool isSearchBar = false;

  late Widget appBarTitleBar;
  late Icon searchIcon;

  @override
  void initState() {
    super.initState();
    appBarTitleBar = titleBar();
    searchIcon = const Icon(Icons.search);
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: appBarTitleBar,
      titleSpacing: 0,
      centerTitle: true,
      backgroundColor: widget.backgroundColor,
      elevation: 0,
      actions: [
        IconButton(
          icon: searchIcon,
          color: Colors.blue,
          onPressed: () {
            setState(() {
              toggleTitleBar();
            });
          },
        ),
      ],
    );

    return appBar;
  }

  void toggleTitleBar() {
    if (!isSearchBar) {
      isSearchBar = true;
      searchIcon = const Icon(Icons.cancel);
      appBarTitleBar = searchBar();
      return;
    }

    isSearchBar = false;
    searchIcon = const Icon(Icons.search);
    appBarTitleBar = titleBar();
  }

  Widget titleBar() {
    Widget titleBar = Text(
      widget.title,
      style: TextStyle(
        color: widget.color,
      ),
    );

    return titleBar;
  }

  // https://blog.logrocket.com/how-to-create-search-bar-flutter/
  Widget searchBar() {
    Widget searchBar = const TextField(
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search, color: Colors.grey),
        fillColor: Colors.black,
        border: InputBorder.none,
        hintText: 'Search by name',
        hintStyle: TextStyle(color: Colors.grey),
      ),
    );

    return searchBar;
  }
}
