import 'package:flutter/material.dart';
import '/utility/model.dart';
import '/utility/utility.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final String _title = "萬能的滾動列表";
  final String _assetsPath = "./lib/assets/sample.json";
  final List<Sample> _sampleList = [];

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    downloadJSON(_assetsPath);
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _title,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
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
  }

  void downloadJSON(String assetsPath) {
    Utility.shared.readJSON(assetsPath: assetsPath).then((value) {
      final list = value['result'] as List<dynamic>;
      final sampleList = Sample.fromList(list);

      setState(() {
        _sampleList.addAll(sampleList);
      });
    });
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
                      sample.title,
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

    ListView _listViewMaker(int itemCount) {
      ListView listView = ListView.separated(
        itemCount: itemCount,
        itemBuilder: ((context, index) {
          return _itemMaker(index);
        }),
        controller: _scrollController,
        separatorBuilder: ((context, index) {
          return const Divider(
            height: 1,
            thickness: 2,
            color: Colors.blueGrey,
          );
        }),
      );

      return listView;
    }

    return _listViewMaker(itemCount);
  }

  void scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }
}
