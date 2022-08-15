import 'dart:developer';

import 'package:flutter/material.dart';

import '/utility/setting.dart';
import '/utility/extension.dart';

class AdvertPage extends StatefulWidget {
  final String title;
  const AdvertPage({Key? key, required this.title}) : super(key: key);

  @override
  State<AdvertPage> createState() => _AdvertPageState();
}

class _AdvertPageState extends State<AdvertPage>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late TabController tabController;
  late List<Tab> tabList;
  late List<Widget> tabViewList;
  late Color? appBarBackgroundColor = Colors.yellowAccent;

  @override
  void initState() {
    super.initState();
    initTabController();
  }

  @override
  void dispose() {
    super.dispose();
    dismissTabController();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabList.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appBarBackgroundColor,
          elevation: 0,
          title: Text(
            widget.title,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          bottom: TabBar(
            tabs: tabList,
            indicatorColor: Colors.blue,
            isScrollable: true,
            controller: tabController,
            onTap: (index) {
              changeBackgroundColor(index: index);
            },
          ),
        ),
        body: TabBarView(
          physics: const BouncingScrollPhysics(),
          controller: tabController,
          children: tabViewList,
        ),
      ),
    );
  }

  void initTabController() {
    tabList = tabsMaker();
    tabViewList = tabsWidgetMaker();

    tabController =
        TabController(initialIndex: 0, length: tabList.length, vsync: this)
          ..animation?.addListener(() {
            tabIndexOffsetOnChangeListener();
          });

    WidgetsBinding.instance.addObserver(this);
  }

  void dismissTabController() {
    tabController.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  // [Flutter：TabController簡單協調TabBar與TabView | IT人](https://iter01.com/12080.html)
  void tabIndexOffsetOnChangeListener() {
    log('${tabController.animation?.value}');

    if (!tabController.isScrolledIndex()) {
      return;
    }

    changeBackgroundColor(index: tabController.index);
  }

  void changeBackgroundColor({required int index}) {
    setState(() {
      appBarBackgroundColor =
          sampleTabModels.safeElementAt(index)?.tabModel.backgroundColor;
    });
  }

  List<Tab> tabsMaker() {
    final tabs = sampleTabModels.map(
      (model) {
        final tab = Text(
          model.tabModel.title,
          style: TextStyle(
            fontSize: 24,
            color: model.tabModel.color,
          ),
        );

        return Tab(child: tab);
      },
    ).toList();

    return tabs;
  }

  List<Widget> tabsWidgetMaker() {
    final bodies = sampleTabModels.map((model) => model.body).toList();
    return bodies;
  }
}
