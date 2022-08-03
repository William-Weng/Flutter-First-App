import 'package:flutter/material.dart';

import '/page/home/homePage.dart';
import '/page/profile/profilePage.dart';
import '/utility/model.dart';

// MARK: - TabBar的資訊
final List<BottomNavigationBarItemModel> tabBarItems = [
  BottomNavigationBarItemModel(
    item: const BottomNavigationBarItem(icon: Icon(Icons.home), label: '第一頁'),
    body: const HomePage(
      title: 'Home',
    ),
  ),
  BottomNavigationBarItemModel(
    item: const BottomNavigationBarItem(icon: Icon(Icons.home), label: '第二頁'),
    body: const ProfilePage(
      title: 'Profile',
    ),
  ),
];
