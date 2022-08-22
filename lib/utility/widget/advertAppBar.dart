import 'package:flutter/material.dart';
import '../extension.dart';

class AdvertAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> tabList;
  final TabController? controller;

  const AdvertAppBar({
    Key? key,
    required this.title,
    required this.tabList,
    required this.controller,
  }) : super(key: key);

  @override
  State<AdvertAppBar> createState() => AdvertAppBarState();

  @override
  Size get preferredSize {
    final appBarSize =
        AppBar().preferredSize.add(const Size(0, kTextTabBarHeight));
    return appBarSize;
  }
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
