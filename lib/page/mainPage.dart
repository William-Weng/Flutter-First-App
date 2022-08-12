import 'package:flutter/material.dart';

import '/utility/setting.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late final List<BottomNavigationBarItem> _items;
  late final List<Widget> _bodies;

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    _items = tabBarItems.map((model) {
      return model.item;
    }).toList();

    _bodies = tabBarItems.map((model) {
      return model.body;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _bodies.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: _items,
        selectedItemColor: Colors.blueAccent,
        backgroundColor: Colors.white,
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
