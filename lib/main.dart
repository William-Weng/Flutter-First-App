import 'package:flutter/material.dart';
import '/page/mainPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // [Flutter 自訂字型 | Titangene Blog](https://titangene.github.io/article/flutter-custom-fonts.html)
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'OpenHuninn'),
      home: const MainPage(),
    );
  }
}
