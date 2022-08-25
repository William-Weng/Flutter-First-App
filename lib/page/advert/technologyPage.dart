import 'dart:developer';

import 'package:flutter/material.dart';

import '/utility/global.dart';
import '/utility/widget/progressIndicator.dart';
import '/utility/model/model.dart';
import '/utility/setting.dart';
import '/utility/utility.dart';
import '/utility/extension.dart';

class TechnologyPage extends StatefulWidget {
  const TechnologyPage({Key? key}) : super(key: key);

  @override
  State<TechnologyPage> createState() => TechnologyPageState();
}

class TechnologyPageState extends State<TechnologyPage> {
  final String assetsPath = "./lib/assets/json/technology.json";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final gridView = GridView.builder(
      key: Utility.shared.pageStorageKey(widget),
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisSpacing: 0,
        crossAxisSpacing: 3,
        childAspectRatio: 2.2,
      ),
      itemCount: Global.technologyModels.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.black,
          ),
          child: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: const BoxDecoration(color: Colors.amber),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Center(
                      child: Text(
                        Global.technologyModels.safeElementAt(index)!.key,
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: itemMaker(xIndex: index),
                ),
              ],
            ),
          ),
        );
      },
    );

    return gridView;
  }

  Widget itemMaker({required int xIndex}) {
    final model = Global.technologyModels.safeElementAt(xIndex);
    final value = model?.value;

    double mainAxisSpacing = 8.0;
    if (Global.technologyModels.isEmpty) {
      mainAxisSpacing = 0;
    }

    return GridView.builder(
      key: Utility.shared.pageStorageKey(widget, key: '$xIndex'),
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisSpacing: mainAxisSpacing,
        crossAxisSpacing: 3,
        childAspectRatio: 1.2,
      ),
      itemCount: value?.length,
      itemBuilder: (context, yIndex) {
        final map = value?.safeElementAt(yIndex) as Map<String, dynamic>?;
        final imageUrl = map?['imageUrl'] as String?;
        return Container(
          decoration: BoxDecoration(color: Utility.shared.randomColor()),
          child: Utility.shared.webImage(
            imageUrl!,
            fit: BoxFit.fill,
            loadingImage: loadingImageName,
            errorImage: errorImageName,
          ),
        );
      },
    );
  }

  void updateJSON() {
    WWProgressIndicator.shared.display();

    Future.delayed(const Duration(milliseconds: 2000)).then((value) {
      simulationDownloadJSON();
    });
  }

  void simulationDownloadJSON() {
    Utility.shared.readJSON(assetsPath: assetsPath).then((value) {
      final list = value['result'] as List<dynamic>;

      WWProgressIndicator.shared.dismiss();

      setState(() {
        Global.technologyModels = Model.fromList(list);
      });
    });
  }
}
