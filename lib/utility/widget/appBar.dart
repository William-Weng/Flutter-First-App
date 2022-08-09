import 'package:flutter/material.dart';

class WWAppBar extends StatefulWidget {
  final String title;
  final Color? color;
  final Color? backgroundColor;

  const WWAppBar(
      {Key? key, required this.title, this.color, this.backgroundColor})
      : super(key: key);

  @override
  State<WWAppBar> createState() => _WWAppBarState();
}

class _WWAppBarState extends State<WWAppBar> {
  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text(
        widget.title,
        style: TextStyle(
          color: widget.color,
        ),
      ),
      centerTitle: true,
      backgroundColor: widget.backgroundColor,
      elevation: 0,
    );

    return appBar;
  }
}
