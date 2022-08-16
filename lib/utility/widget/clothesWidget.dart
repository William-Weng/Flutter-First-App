import 'package:flutter/material.dart';
import 'package:flutter_first_app/utility/widget/progressIndicator.dart';
import '/utility/setting.dart';
import '/utility/utility.dart';
import '/utility/extension.dart';
import '/utility/model/clothes.dart';

class ClothesWidget extends StatefulWidget {
  const ClothesWidget({Key? key}) : super(key: key);

  @override
  State<ClothesWidget> createState() => _ClothesWidgetState();
}

class _ClothesWidgetState extends State<ClothesWidget> {
  final ScrollController _scrollController = ScrollController();
  final String assetsPath = "./lib/assets/json/clothes.json";

  bool isDownloading = false;
  List<ClothesModel> models = [];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(scrollingListener);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      simulationDownloadJSON();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
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
      itemCount: models.length,
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

    final model = models.safeElementAt(index);

    if (model == null) {
      return Utility.shared.assetImage('./lib/assets/images/404.jpeg');
    }

    final src = model.imageUrl;
    final image = Utility.shared.webImage(src);

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

  void scrollingListener() {
    final offset = _scrollController.offset;

    if (isDownloading) {
      return;
    }

    if (offset < -offsetRange) {
      simulationDownloadJSON(isReload: true);
    }

    if (offset >= _scrollController.position.maxScrollExtent + offsetRange) {
      if (models.length >= maxDownloadCount) {
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
    WWProgressIndicator.shared.display(context);

    isDownloading = true;

    downloadJSON(
      assetsPath,
      action: (list) {
        Future.delayed(const Duration(seconds: simulationSeconds))
            .then((value) => {
                  WWProgressIndicator.shared.dismiss(context),
                  isDownloading = false,
                  setState(() {
                    if (!isReload) {
                      models.addAll(list);
                      return;
                    }

                    models = list;
                  }),
                });
      },
    );
  }
}
