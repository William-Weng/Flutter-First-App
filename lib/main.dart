import 'package:flutter/material.dart';
import 'package:flutter_first_app/page/advert/webPage.dart';
import '/page/mainPage.dart';

void main() {
  runApp(const MyApp());
}

// [30天Flutter手滑系列 - 狀態管理 (State Management)](https://ithelp.ithome.com.tw/articles/10217200)
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // [Flutter 自訂字型 | Titangene Blog](https://titangene.github.io/article/flutter-custom-fonts.html)
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'OpenHuninn'),
      // home: const MainPage(),
      home: const WebPage(),
    );
  }
}
