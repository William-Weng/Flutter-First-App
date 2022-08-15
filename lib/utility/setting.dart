import 'package:flutter/material.dart';
import 'package:flutter_first_app/page/advert/advertPage.dart';

import '/page/home/homePage.dart';
import '/page/profile/profilePage.dart';
import 'model/bottomNavigationBarItemModel.dart';
import 'model/sampleDefaultTabModel.dart';

// MARK: - TabBar的資訊
final List<BottomNavigationBarItemModel> tabBarItems = [
  BottomNavigationBarItemModel(
    item: const BottomNavigationBarItem(icon: Icon(Icons.home), label: '生命週期'),
    body: const HomePage(title: '生命週期'),
  ),
  BottomNavigationBarItemModel(
    item: const BottomNavigationBarItem(icon: Icon(Icons.home), label: '滾動列表'),
    body: const ProfilePage(title: '角落生物'),
  ),
  BottomNavigationBarItemModel(
    item: const BottomNavigationBarItem(icon: Icon(Icons.pages), label: '廣告頁面'),
    body: const AdvertPage(title: '買東買西'),
  ),
];

final List<SampleDefaultTabModel> sampleTabModels = [
  SampleDefaultTabModel(
    tabModel: TabModel(
        title: "衣服", color: Colors.black, backgroundColor: Colors.yellow),
    body: const Center(
      child: Text('就是衣服'),
    ),
  ),
  SampleDefaultTabModel(
    tabModel: TabModel(
        title: "褲子", color: Colors.black, backgroundColor: Colors.green),
    body: const Center(
      child: Text('就是褲子'),
    ),
  ),
  SampleDefaultTabModel(
    tabModel: TabModel(
        title: "上衣", color: Colors.black, backgroundColor: Colors.indigo),
    body: const Center(
      child: Text('就是上衣'),
    ),
  ),
  SampleDefaultTabModel(
    tabModel: TabModel(
        title: "運動鞋", color: Colors.black, backgroundColor: Colors.grey),
    body: const Center(
      child: Text('就是運動鞋'),
    ),
  ),
  SampleDefaultTabModel(
    tabModel: TabModel(
        title: "衣服", color: Colors.black, backgroundColor: Colors.amber),
    body: const Center(
      child: Text('就是衣服'),
    ),
  ),
  SampleDefaultTabModel(
    tabModel: TabModel(
        title: "3C", color: Colors.black, backgroundColor: Colors.lightGreen),
    body: const Center(
      child: Text('就是3C'),
    ),
  ),
  SampleDefaultTabModel(
    tabModel: TabModel(
        title: "電器", color: Colors.black, backgroundColor: Colors.pinkAccent),
    body: const Center(
      child: Text('就是電器'),
    ),
  ),
];
