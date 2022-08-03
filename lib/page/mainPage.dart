import 'package:flutter/material.dart';

import '../page/home/homePage.dart';
import '../page/profile/profilePage.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _tabs = [
    const HomePage(title: '<首頁>'),
    const ProfilePage(title: '<次頁>'),
  ];

  final items = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: '第一頁'),
    const BottomNavigationBarItem(icon: Icon(Icons.phone), label: '第二頁'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: items,
        onTap: ((index) {
          setState(() {
            _selectedIndex = index;
          });
        }),
      ),
    );
  }
}
