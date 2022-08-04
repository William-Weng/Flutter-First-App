import 'package:flutter/material.dart';
import '/utility/setting.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<BottomNavigationBarItem> _items = tabBarItems.map((model) {
    return model.item;
  }).toList();

  final List<Widget> _bodies = tabBarItems.map((model) {
    return model.body;
  }).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodies.elementAt(_selectedIndex),
      extendBody: true,
      bottomNavigationBar: BottomNavigationBar(
        items: _items,
        selectedItemColor: Colors.blueAccent,
        backgroundColor: Colors.transparent,
        elevation: 0,
        currentIndex: _selectedIndex,
        onTap: ((index) {
          setState(() {
            _selectedIndex = index;
          });
        }),
      ),
    );
  }
}
