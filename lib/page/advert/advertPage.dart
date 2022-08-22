import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_first_app/page/technology/technologyPage.dart';

import 'advertClothesPage.dart';
import '/utility/setting.dart';
import '/utility/extension.dart';
import '/utility/widget/advertAppBar.dart';

class AdvertPage extends StatefulWidget {
  final String title;
  final String assetsPath = "./lib/assets/json/clothes.json";

  const AdvertPage({Key? key, required this.title}) : super(key: key);

  @override
  State<AdvertPage> createState() => _AdvertPageState();
}

class _AdvertPageState extends State<AdvertPage>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late Color? appBarBackgroundColor = Colors.yellowAccent;
  late TabController tabController;
  late List<Tab> tabList;
  late List<Widget> tabViewList;

  // [Flutter性能优化之局部刷新 - 简书](https://www.jianshu.com/p/23a2e8a96a79)
  GlobalKey<AdvertAppBarState> appBarKey = GlobalKey();
  GlobalKey<AdvertClothesPageState> advertClothesPageKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    initTabController();
    changeBackgroundColor(color: Colors.yellowAccent);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      advertClothesPageKey.currentState?.updateJSON();
    });
  }

  @override
  void dispose() {
    dismissTabController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabList.length,
      child: Scaffold(
        appBar: AdvertAppBar(
          key: appBarKey,
          title: widget.title,
          tabList: tabList,
          controller: tabController,
        ),

        /// https://www.gushiciku.cn/pl/gztx/zh-tw
        body: TabBarView(
          physics: const BouncingScrollPhysics(),
          controller: tabController,
          children: [
            AdvertClothesPage(key: advertClothesPageKey),
            const Center(child: Text('404')),
            const TechnologyPage(),
            const Center(child: Text('404')),
            const Center(child: Text('404')),
            const Center(child: Text('404')),
            const Center(child: Text('404')),
          ],
        ),
      ),
    );
  }

  void initTabController() {
    tabList = tabsMaker();
    tabViewList = tabsWidgetMaker();

    tabController =
        TabController(initialIndex: 0, length: tabList.length, vsync: this)
          ..animation?.addListener(() => tabIndexOffsetOnChangeListener());

    WidgetsBinding.instance.addObserver(this);
  }

  void dismissTabController() {
    tabController.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  // [Flutter：TabController簡單協調TabBar與TabView | IT人](https://iter01.com/12080.html)
  // [Flutter中关于setState的理解(三) - 簡書](https://www.jianshu.com/p/24018d234210)
  void tabIndexOffsetOnChangeListener() {
    final animation = tabController.animation;

    if (animation == null) {
      return;
    }

    final direction = tabController.scrollDirection();
    final scrollingOffset = animation.value;

    final indexColor = sampleTabModels
        .safeElementAt(tabController.index)
        ?.tabModel
        .backgroundColor;

    final nextIndex = (direction != AnimationStatus.reverse)
        ? (tabController.index + 1)
        : (tabController.index - 1);

    final nextIndexColor =
        sampleTabModels.safeElementAt(nextIndex)?.tabModel.backgroundColor;

    var opacity = (direction != AnimationStatus.reverse)
        ? (scrollingOffset - tabController.index.toDouble())
        : (-scrollingOffset + tabController.index.toDouble());

    if (opacity > 1.0) {
      opacity = 1.0;
    }

    // [Widget 的 Key（一）](https://openhome.cc/Gossip/Flutter/Key.html)
    if (opacity < 0.5) {
      opacity = 1 - opacity;
      changeBackgroundColor(color: indexColor?.withOpacity(opacity));
    } else {
      changeBackgroundColor(color: nextIndexColor?.withOpacity(opacity));
    }

    if (!tabController.isScrolledIndex()) {
      log('tabIndex => ${tabController.index}');
      return;
    }

    changeBackgroundColor(color: indexColor);
  }

  void changeBackgroundColor({required Color? color}) {
    appBarKey.currentState?.updateColor(color);
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
