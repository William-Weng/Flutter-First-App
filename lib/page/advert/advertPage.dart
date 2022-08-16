import 'package:flutter/material.dart';

import '/utility/widget/clothesWidget.dart';
import '/utility/setting.dart';
import '/utility/extension.dart';

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

  @override
  void initState() {
    super.initState();
    initTabController();
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
            onTap: (index) {},
          ),
        ),

        /// https://www.gushiciku.cn/pl/gztx/zh-tw
        body: TabBarView(
          physics: const BouncingScrollPhysics(),
          controller: tabController,
          children: const [
            ClothesWidget(),
            Center(child: Text('404')),
            Center(child: Text('404')),
            Center(child: Text('404')),
            Center(child: Text('404')),
            Center(child: Text('404')),
            Center(child: Text('404')),
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
  void tabIndexOffsetOnChangeListener() {
    final animation = tabController.animation;

    if (animation == null) {
      return;
    }

    final direction = tabController.scrollDirection();

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
        ? (animation.value - tabController.index.toDouble())
        : (-animation.value + tabController.index.toDouble());

    if (opacity > 1.0) {
      opacity = 1.0;
    }

    if (opacity < 0.5) {
      opacity = 1 - opacity;
      changeBackgroundColor(color: indexColor?.withOpacity(opacity));
    } else {
      changeBackgroundColor(color: nextIndexColor?.withOpacity(opacity));
    }

    if (!tabController.isScrolledIndex()) {
      return;
    }

    changeBackgroundColor(color: indexColor);
  }

  void changeBackgroundColor({required Color? color}) {
    setState(() {
      appBarBackgroundColor = color;
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
