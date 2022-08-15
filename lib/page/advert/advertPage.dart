import 'package:flutter/material.dart';

import '/utility/setting.dart';

class AdvertPage extends StatefulWidget {
  final String title;
  const AdvertPage({Key? key, required this.title}) : super(key: key);

  @override
  State<AdvertPage> createState() => _AdvertPageState();
}

class _AdvertPageState extends State<AdvertPage> {
  late List<Tab> _tabList;
  late List<Widget> _tabViewList;

  @override
  void initState() {
    super.initState();
    _tabList = tabsMaker();
    _tabViewList = tabsWidgetMaker();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabList.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellowAccent,
          elevation: 0,
          title: Text(
            widget.title,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          bottom: TabBar(
            tabs: _tabList,
            indicatorColor: Colors.blue,
            isScrollable: true,
          ),
        ),
        body: TabBarView(children: _tabViewList),
      ),
    );
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
