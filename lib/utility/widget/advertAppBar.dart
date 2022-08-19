import 'package:flutter/material.dart';

class AdvertAppBar extends StatefulWidget implements PreferredSizeWidget {
  String title;
  List<Widget> tabList;
  TabController? controller;

  AdvertAppBar({
    Key? key,
    required this.title,
    required this.tabList,
    required this.controller,
  }) : super(key: key);

  @override
  State<AdvertAppBar> createState() => AdvertAppBarState();

  @override
  Size get preferredSize => Size(100, 100);
}

class AdvertAppBarState extends State<AdvertAppBar> {
  Color? backgroundColor = Colors.yellowAccent;

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      title: Text(
        widget.title,
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
      centerTitle: true,
      bottom: TabBar(
        tabs: widget.tabList,
        indicatorColor: Colors.blue,
        isScrollable: true,
        controller: widget.controller,
      ),
    );

    return appBar;
  }

  void updateColor(Color? color) {
    setState(() {
      backgroundColor = color;
    });
  }
}
