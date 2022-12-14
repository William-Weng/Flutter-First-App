import 'dart:developer';

import 'package:flutter/material.dart';

import '/utility/global.dart';
import '/utility/widget/progressIndicator.dart';
import '/utility/setting.dart';
import '/utility/utility.dart';
import '/utility/extension.dart';
import '../../utility/model/clothesModel.dart';

class AdvertClothesPage extends StatefulWidget {
  const AdvertClothesPage({Key? key}) : super(key: key);

  @override
  State<AdvertClothesPage> createState() => AdvertClothesPageState();
}

class AdvertClothesPageState extends State<AdvertClothesPage> {
  final ScrollController _scrollController = ScrollController();
  final String assetsPath = "./lib/assets/json/clothes.json";

  bool isDownloading = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(scrollingListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gridView = GridView.builder(
      key: Utility.shared.pageStorageKey(widget),
      physics: const BouncingScrollPhysics(),
      controller: _scrollController,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 3,
        childAspectRatio: 0.85,
      ),
      itemCount: Global.clothesList.length,
      itemBuilder: (context, index) => _gridViewItem(context, index),
    );

    return gridView;
  }

  Widget _gridViewItem(BuildContext context, int index) {
    List<Widget> _colorBoxes(List<Color> colors) {
      final items = colors.map((color) {
        final item = Container(
          margin: const EdgeInsets.all(2.0),
          width: 20,
          color: color,
        );

        return item;
      }).toList();

      return items.toList();
    }

    final model = Global.clothesList.safeElementAt(index);

    if (model == null) {
      return Utility.shared.assetImage(
        errorImageName,
        errorImage: errorImageName,
      );
    }

    final src = model.imageUrl;
    final image = Utility.shared.webImage(
      src,
      loadingImage: loadingImageName,
      errorImage: errorImageName,
    );

    final item = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 8, child: image),
        Expanded(flex: 1, child: Row(children: _colorBoxes(model.colors))),
        Text(
          model.title,
          textAlign: TextAlign.left,
          softWrap: false,
          overflow: TextOverflow.fade,
        ),
      ],
    );

    return item;
  }

  void updateJSON() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      simulationDownloadJSON();
    });
  }

  void scrollingListener() {
    final offset = _scrollController.offset;

    if (isDownloading) {
      return;
    }

    if (offset < -offsetRange) {
      simulationDownloadJSON(isReload: true);
    }

    if (offset >= _scrollController.position.maxScrollExtent + offsetRange) {
      if (Global.clothesList.length >= maxDownloadCount) {
        return;
      }
      simulationDownloadJSON();
    }
  }

  void downloadJSON(String assetsPath,
      {required Function(List<ClothesModel>) action}) {
    Utility.shared.readJSON(assetsPath: assetsPath).then((value) {
      final list = value['result'] as List<dynamic>;
      final sampleList = ClothesModel.fromList(list);

      action(sampleList);
    });
  }

  void simulationDownloadJSON({bool isReload = false}) {
    // [viewDidAppear()](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621423-viewdidappear)
    if (!mounted) {
      return;
    }

    isDownloading = true;
    WWProgressIndicator.shared.display();

    downloadJSON(
      assetsPath,
      action: (list) {
        Future.delayed(const Duration(seconds: simulationSeconds))
            .then((value) {
          WWProgressIndicator.shared.dismiss();
          isDownloading = false;
          setState(() {
            if (!isReload) {
              Global.clothesList.addAll(list);
              return;
            }

            Global.clothesList = list;
          });
        });
      },
    );
  }
}
