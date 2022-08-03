import 'package:flutter/material.dart';

import '/page/home/homePage.dart';
import '/page/profile/profilePage.dart';
import '/utility/model.dart';

// MARK: - TabBar的資訊
final List<BottomNavigationBarItemModel> tabBarItems = [
  BottomNavigationBarItemModel(
    item: const BottomNavigationBarItem(icon: Icon(Icons.home), label: '生命週期'),
    body: const HomePage(
      title: 'Life Cycle',
    ),
  ),
  BottomNavigationBarItemModel(
    item: const BottomNavigationBarItem(icon: Icon(Icons.home), label: '滾動列表'),
    body: const ProfilePage(
      title: 'ListView',
    ),
  ),
];
