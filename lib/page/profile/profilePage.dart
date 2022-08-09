import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_first_app/utility/widget/appBar.dart';

import '/page/profile/profileDetailPage.dart';
import '/utility/model.dart';
import '/utility/utility.dart';
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
  final int simulationSeconds = 2;
  final ScrollController _scrollController = ScrollController();

  bool isDownloading = false;
  List<Sample> _sampleList = [];

  @override
  void initState() {
    super.initState();

    downloadJSON(
      widget.assetsPath,
      action: (list) {
        setState(() {
          _sampleList.addAll(list);
        });
      },
    );

    _scrollController.addListener(() {
      final offset = _scrollController.offset;

      if (isDownloading) {
        return;
      }

      if (offset <= 0) {
        simulationReloadJSON();
      }

      if (offset >= _scrollController.position.maxScrollExtent) {
        if (_sampleList.length >= widget.maxDownloadCount) {
          return;
        }
        simulationDownloadJSON();
      }
    });
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

  Widget bodyMaker(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    final bodyWidget = Scaffold(
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: WWAppBar(
          title: widget.title,
          color: Colors.black,
          backgroundColor: Colors.transparent,
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
        height: 200.0,
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

    ListView _listViewMaker(int itemCount) {
      ListView listView = ListView.separated(
        itemCount: itemCount,
        itemBuilder: ((context, index) {
          final onTapItem = GestureDetector(
            child: _itemMaker(index),
            onTap: () {
              itemOnTap(index);
            },
          );

          return onTapItem;
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

  void itemOnTap(int index) {
    final sample = _sampleList.elementAt(index);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProfileDetailPage(sample: sample)));
  }

  void scrollToTop() {
    _scrollController.animateTo(
      0.1,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }

  void simulationReloadJSON() {
    WWProgressIndicator.shared.display(context);
    isDownloading = true;

    downloadJSON(
      widget.assetsPath,
      action: (list) {
        Future.delayed(Duration(seconds: simulationSeconds)).then((value) => {
              WWProgressIndicator.shared.dismiss(context),
              isDownloading = false,
              setState(() {
                _sampleList = list;
              }),
            });
      },
    );
  }

  void simulationDownloadJSON() {
    WWProgressIndicator.shared.display(context);

    isDownloading = true;

    downloadJSON(
      widget.assetsPath,
      action: (list) {
        Future.delayed(Duration(seconds: simulationSeconds)).then((value) => {
              WWProgressIndicator.shared.dismiss(context),
              isDownloading = false,
              setState(() {
                _sampleList.addAll(list);
              }),
            });
      },
    );
  }

  void downloadJSON(String assetsPath,
      {required Function(List<Sample>) action}) {
    Utility.shared.readJSON(assetsPath: assetsPath).then((value) {
      final list = value['result'] as List<dynamic>;
      final sampleList = Sample.fromList(list);

      action(sampleList);
    });
  }
}
