import 'package:flutter/material.dart';

class WWSearchBar extends StatefulWidget {
  final String title;
  final Color? color;
  final Color? backgroundColor;
  final Function(String) searchAction;
  final Function(bool) toggleAction;

  const WWSearchBar({
    Key? key,
    required this.title,
    required this.searchAction,
    required this.toggleAction,
    this.color,
    this.backgroundColor,
  }) : super(key: key);

  @override
  State<WWSearchBar> createState() => _WWSearchBarState();
}

class _WWSearchBarState extends State<WWSearchBar> {
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
      appBarTitleBar = searchBar((value) => {widget.searchAction(value)});
    } else {
      isSearchBar = false;
      searchIcon = const Icon(Icons.search);
      appBarTitleBar = titleBar();
    }

    widget.toggleAction(isSearchBar);
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
  Widget searchBar(Function(String) submitAction) {
    Widget searchBar = TextField(
      style: const TextStyle(color: Colors.black),
      autofocus: true,
      textInputAction: TextInputAction.search,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.search, color: Colors.grey),
        fillColor: Colors.black,
        border: InputBorder.none,
        hintText: 'Search by name',
        hintStyle: TextStyle(color: Colors.grey),
      ),
      onSubmitted: submitAction,
    );

    return searchBar;
  }
}
