import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_first_app/utility/widget/searchBar.dart';
import 'package:http/http.dart';

import '/page/profile/profileDetailPage.dart';
import '/utility/model.dart';
import '/utility/utility.dart';
import '/utility/extension.dart';
import '/utility/widget/progressIndicator.dart';

class ProfilePage extends StatefulWidget {
  final String title;
  final String assetsPath = "./lib/assets/sample.json";
  final int maxDownloadCount = 20;

  const ProfilePage({Key? key, required this.title}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final double itemHeight = 200.0;
  final int simulationSeconds = 2;
  final int offsetRange = 100;
  final ScrollController _scrollController = ScrollController();

  bool isSearchBar = false;
  bool isDownloading = false;
  List<Sample> _sampleList = [];
  List<Sample> _fullSampleList = [];

  late String _title = widget.title;

  // MARK: - 生命週期
  @override
  void initState() {
    super.initState();
    initSetting();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return bodyMaker(context);
  }

  // MARK: - 小工具
  void initSetting() {
    // downloadJSON(widget.assetsPath, action: (list) { setState(() { _sampleList.addAll(list); });},);

    _scrollController.addListener(scrollingListener);

    downloadHttpJSON().then((list) => {
          setState(() {
            _sampleList.addAll(list);
          }),
        });
  }

  void itemOnTap(int index) {
    final sample = _sampleList.elementAt(index);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProfileDetailPage(sample: sample)));
  }

  void scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }

  void scrollingListener() {
    final offset = _scrollController.offset;

    changeTitle(offset);

    if (isDownloading) {
      return;
    }

    if (isSearchBar) {
      return;
    }

    // if (_scrollController.position.activity == null) { return; }
    // double velocity = _scrollController.position.activity!.velocity;

    if (offset < -offsetRange) {
      simulationReloadJSON();
    }

    if (offset >= _scrollController.position.maxScrollExtent + offsetRange) {
      if (_sampleList.length >= widget.maxDownloadCount) {
        return;
      }
      simulationDownloadJSON();
    }
  }

  void simulationReloadJSON() {
    WWProgressIndicator.shared.display(context);
    isDownloading = true;

    // downloadJSON(widget.assetsPath, action: (list) { Future.delayed(Duration(seconds: simulationSeconds)).then((value) => { WWProgressIndicator.shared.dismiss(context), isDownloading = false, setState(() { _sampleList = list; }),});},);

    downloadHttpJSON().then((list) => {
          WWProgressIndicator.shared.dismiss(context),
          isDownloading = false,
          setState(() {
            _sampleList = list;
          }),
        });
  }

  void simulationDownloadJSON() {
    WWProgressIndicator.shared.display(context);

    isDownloading = true;

    // downloadJSON(widget.assetsPath, action: (list) { Future.delayed(Duration(seconds: simulationSeconds)).then((value) => { WWProgressIndicator.shared.dismiss(context), isDownloading = false, setState(() { _sampleList.addAll(list); }),});},);
    downloadHttpJSON().then((list) => {
          WWProgressIndicator.shared.dismiss(context),
          isDownloading = false,
          setState(() {
            _sampleList.addAll(list);
          }),
        });
  }

  void downloadJSON(String assetsPath,
      {required Function(List<Sample>) action}) {
    Utility.shared.readJSON(assetsPath: assetsPath).then((value) {
      final list = value['result'] as List<dynamic>;
      final sampleList = Sample.fromList(list);

      action(sampleList);
    });
  }

  Future<List<Sample>> downloadHttpJSON() async {
    final url = Uri.https("jsonplaceholder.typicode.com", '/users');
    final response = await get(url);
    final json = const JsonDecoder().convert(response.body.toString());

    return UserSample.fromListToSample(json);
  }

  void changeTitle(double offset) {
    final fixOffset = offset - 45;
    final index = fixOffset ~/ itemHeight;
    final sample = _sampleList.safeElementAt(index) as Sample?;

    String indexTitle = widget.title;

    if (sample != null) {
      if (fixOffset > 0) {
        indexTitle = sample.title;
      }
    }

    if (_title == indexTitle) {
      return;
    }

    setState(() {
      _title = indexTitle;
    });
  }

  // MARK: - Widget
  Widget bodyMaker(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    final bodyWidget = Scaffold(
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: WWSearchBar(
          title: _title,
          color: Colors.black,
          backgroundColor: Colors.white,
          searchAction: (value) {
            List<Sample> list = [];

            for (var sample in _sampleList) {
              if (sample.title.toLowerCase().contains(value.toLowerCase())) {
                list.add(sample);
              }
            }

            setState(() {
              _sampleList = list.toList();
            });
          },
          toggleAction: (isSearchBar) {
            this.isSearchBar = isSearchBar;

            if (!isSearchBar) {
              setState(() {
                _sampleList = _fullSampleList.toList();
              });
            } else {
              _fullSampleList = _sampleList.toList();
            }
          },
        ),
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.amber.shade100,
      body: listViewBuilder(_sampleList.length),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: bottomPadding),
        child: FloatingActionButton(
          onPressed: scrollToTop,
          tooltip: '回到第一個',
          child: const Icon(Icons.arrow_upward),
        ),
      ),
    );

    return bodyWidget;
  }

  ListView listViewBuilder(int itemCount) {
    Widget _itemMaker(int index) {
      final sample = _sampleList.elementAt(index);

      final widget = SizedBox(
        height: itemHeight,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              sample.imageUrl,
              fit: BoxFit.fitWidth,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(96, 0, 0, 0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: Text(
                      '(${index + 1}) ${sample.title}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: Colors.black87,
                      ),
                    )),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(64, 0, 0, 0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(sample.content),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );

      return widget;
    }

    Divider _dividerMaker(int index) {
      return const Divider(
        height: 1,
        thickness: 2,
        color: Colors.blueGrey,
      );
    }

    // [Flutter完整开发实战详解(十八、 神奇的ScrollPhysics与Simulation)](https://zhuanlan.zhihu.com/p/84716922)
    ListView _listViewMaker(int itemCount) {
      ListView listView = ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemCount: itemCount,
        itemBuilder: ((context, index) {
          final onTapItem = GestureDetector(
            child: _itemMaker(index),
            onTap: () {
              itemOnTap(index);
            },
          );

          final cancelButton = Container(
            color: Colors.green,
            alignment: Alignment.centerLeft,
            child: const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Icon(
                Icons.cancel,
                color: Colors.white,
              ),
            ),
          );

          final deleteButton = Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            child: const Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
          );

          return Dismissible(
            key: UniqueKey(),
            background: cancelButton,
            secondaryBackground: deleteButton,
            // direction: DismissDirection.endToStart,
            child: onTapItem,
            onDismissed: (direction) {
              setState(() {
                _sampleList.removeAt(index);
              });
            },
            // https://www.youtube.com/watch?v=rFlYNqjwPeA
            confirmDismiss: (direction) {
              switch (direction) {
                case DismissDirection.endToStart:
                  return Future.value(true);
                default:
                  return Future.value(false);
              }
            },
          );
        }),
        controller: _scrollController,
        separatorBuilder: ((context, index) {
          return _dividerMaker(index);
        }),
      );

      return listView;
    }

    return _listViewMaker(itemCount);
  }
}
