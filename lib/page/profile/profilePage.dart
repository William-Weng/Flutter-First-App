import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_first_app/utility/setting.dart';
import 'package:http/http.dart';

import '/utility/constant.dart';
import '/utility/global.dart';
import '/utility/transition.dart';
import '/utility/widget/searchBar.dart';
import '/utility/model/bottomNavigationBarItemModel.dart';
import '/utility/utility.dart';
import '/utility/extension.dart';
import '/utility/widget/progressIndicator.dart';

import '/page/profile/profileDetailPage.dart';

class ProfilePage extends StatefulWidget {
  final String title;
  final String assetsPath = "./lib/assets/json/sample.json";
  final int maxDownloadCount = 20;

  const ProfilePage({Key? key, required this.title}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final double itemHeight = 200.0;
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
    Global.sampleList = _sampleList.toList();
  }

  @override
  Widget build(BuildContext context) {
    return bodyMaker(context);
  }

  // MARK: - 小工具
  void initSetting() {
    _scrollController.addListener(scrollingListener);

    if (Global.sampleList.isNotEmpty) {
      _sampleList = Global.sampleList.toList();
      return;
    }

    // https://stackoverflow.com/questions/47592301/setstate-or-markneedsbuild-called-during-build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      simulationReloadJSON();
    });
  }

  void itemOnTap(int index) {
    final sample = _sampleList.elementAt(index);

    Navigator.push(
      context,
      PageRouteTransition.shared.sampleAnimation(
        TransitionPosition.none,
        duration: const Duration(milliseconds: 500),
        nextPage: ProfileDetailPage(
          index: index,
          sample: sample,
        ),
      ),
      // MaterialPageRoute(builder: (context) => ProfileDetailPage(sample: sample)),
    );
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
    WWProgressIndicator.shared.display();
    isDownloading = true;

    downloadJSON(
      widget.assetsPath,
      action: (list) {
        Future.delayed(const Duration(seconds: simulationSeconds))
            .then((value) => {
                  WWProgressIndicator.shared.dismiss(),
                  isDownloading = false,
                  setState(() {
                    _sampleList = list;
                  }),
                });
      },
    );

    // downloadHttpJSON().then((list) => {
    //       WWProgressIndicator.shared.dismiss(context),
    //       isDownloading = false,
    //       setState(() {
    //         _sampleList = list;
    //       }),
    //     });
  }

  void simulationDownloadJSON() {
    WWProgressIndicator.shared.display();

    isDownloading = true;

    downloadJSON(
      widget.assetsPath,
      action: (list) {
        Future.delayed(const Duration(seconds: simulationSeconds))
            .then((value) {
          WWProgressIndicator.shared.dismiss();
          isDownloading = false;
          setState(() {
            _sampleList.addAll(list);
          });
        });
      },
    );

    // downloadHttpJSON().then((list) => {
    //       WWProgressIndicator.shared.dismiss(context),
    //       isDownloading = false,
    //       setState(() {
    //         _sampleList.addAll(list);
    //       }),
    //     });
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
    final sample = _sampleList.safeElementAt(index);

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
          iconTheme: const IconThemeData(color: Colors.blue),
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
      // https://blog.logrocket.com/how-to-add-navigation-drawer-flutter/
      //endDrawer: ,
      drawer: Drawer(
        backgroundColor: Colors.yellow.shade200,
        child: ListView(
          children: [
            const DrawerHeader(
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                  image: AssetImage(
                    './lib/assets/images/menu.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: null,
            ),
            Card(
              child: ListTile(
                title: const Text("Battery Full"),
                subtitle: const Text("The battery is full."),
                leading: const Icon(Icons.battery_full),
                trailing: const Icon(Icons.star),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Card(
              child: ListTile(
                title: const Text("Anchor"),
                subtitle: const Text("Lower the anchor."),
                leading: const Icon(Icons.anchor),
                trailing: const Icon(Icons.star),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Card(
              child: ListTile(
                title: const Text("Alarm"),
                subtitle: const Text("This is the time."),
                leading: const Icon(Icons.access_alarm),
                trailing: const Icon(Icons.star),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
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
            Hero(
              tag: "Hero_$index",
              child: Utility.shared.webImage(
                sample.imageUrl,
                fit: BoxFit.fitWidth,
                errorImage: errorImageName,
                loadingImage: loadingImageName,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(96, 255, 0, 0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: Text(
                      '(${index + 1}) ${sample.title}',
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.black87,
                      ),
                    )),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(8, 0, 0, 0),
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
    // [Flutter：ListView-ScrollPhysics 詳細介紹（翻譯） - 掘金](https://juejin.cn/post/6844903705192431623)
    // [ScrollPhysics | Flutter | 老孟](http://laomengit.com/flutter/widgets/ScrollPhysics.html#neverscrollablescrollphysics)
    ListView _listViewMaker(int itemCount) {
      ListView listView = ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemCount: itemCount,
        key: Utility.shared.pageStorageKey(widget),
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
              bool canAction = false;

              switch (direction) {
                case DismissDirection.endToStart:
                  canAction = true;
                  break;
                default:
                  canAction = false;
                  break;
              }

              return Future.value(canAction);
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
