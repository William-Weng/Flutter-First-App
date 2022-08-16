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
        title: "衣服",
        color: Colors.black,
        backgroundColor: const Color.fromARGB(255, 204, 255, 153)),
    body: GridView.count(
      padding: const EdgeInsets.all(10),
      scrollDirection: Axis.vertical,
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: [
        Container(
          color: Colors.lightBlue,
        ),
        Container(
          color: Colors.lightBlue,
        ),
        Container(
          color: Colors.lightBlue,
        ),
        Container(
          color: Colors.lightBlue,
        ),
        Container(
          color: Colors.lightBlue,
        ),
        Container(
          color: Colors.lightBlue,
        ),
        Container(
          color: Colors.lightBlue,
        ),
        Container(
          color: Colors.lightBlue,
        ),
        Container(
          color: Colors.lightBlue,
        ),
        Container(
          color: Colors.lightBlue,
        ),
        Container(
          color: Colors.lightBlue,
        ),
      ],
    ),
  ),
  SampleDefaultTabModel(
    tabModel: TabModel(
        title: "褲子",
        color: Colors.black,
        backgroundColor: const Color.fromARGB(255, 204, 255, 204)),
    body: const Center(
      child: Text('就是褲子'),
    ),
  ),
  SampleDefaultTabModel(
    tabModel: TabModel(
        title: "上衣",
        color: Colors.black,
        backgroundColor: const Color.fromARGB(255, 204, 255, 255)),
    body: const Center(
      child: Text('就是上衣'),
    ),
  ),
  SampleDefaultTabModel(
    tabModel: TabModel(
        title: "運動鞋",
        color: Colors.black,
        backgroundColor: const Color.fromARGB(255, 255, 255, 204)),
    body: const Center(
      child: Text('就是運動鞋'),
    ),
  ),
  SampleDefaultTabModel(
    tabModel: TabModel(
        title: "衣服",
        color: Colors.black,
        backgroundColor: const Color.fromARGB(255, 255, 204, 204)),
    body: const Center(
      child: Text('就是衣服'),
    ),
  ),
  SampleDefaultTabModel(
    tabModel: TabModel(
        title: "3C",
        color: Colors.black,
        backgroundColor: const Color.fromARGB(255, 255, 153, 255)),
    body: const Center(
      child: Text('就是3C'),
    ),
  ),
  SampleDefaultTabModel(
    tabModel: TabModel(
        title: "電器",
        color: Colors.black,
        backgroundColor: const Color.fromARGB(255, 204, 255, 0)),
    body: const Center(
      child: Text('就是電器'),
    ),
  ),
];
