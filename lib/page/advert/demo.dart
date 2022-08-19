import 'package:flutter/material.dart';

class MyDemo extends StatefulWidget {
  const MyDemo({Key? key}) : super(key: key);

  @override
  State<MyDemo> createState() => _MyDemoState();
}

class _MyDemoState extends State<MyDemo> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'MyDemo',
        style: TextStyle(
          fontSize: 56,
        ),
      ),
    );
  }
}
