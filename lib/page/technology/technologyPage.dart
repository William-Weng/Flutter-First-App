import 'package:flutter/material.dart';

import '/utility/utility.dart';

class TechnologyPage extends StatefulWidget {
  const TechnologyPage({Key? key}) : super(key: key);

  @override
  State<TechnologyPage> createState() => _TechnologyPageState();
}

class _TechnologyPageState extends State<TechnologyPage> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      key: Utility.shared.pageStorageKey(widget),
      physics: const BouncingScrollPhysics(),
      // controller: _scrollController,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisSpacing: 8,
        crossAxisSpacing: 3,
        childAspectRatio: 2.2,
      ),
      itemCount: 20,
      itemBuilder: (context, index) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
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
                        '$index',
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
  }

  Widget itemMaker({required int xIndex}) {
    return GridView.builder(
      key: Utility.shared.pageStorageKey(widget, key: '$xIndex'),
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      // controller: _scrollController,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisSpacing: 8,
        crossAxisSpacing: 3,
        childAspectRatio: 1.2,
      ),
      itemCount: 20,
      itemBuilder: (context, yIndex) {
        return Container(
          decoration: BoxDecoration(color: Utility.shared.randomColor()),
          child: Center(
            child: Text('($xIndex, $yIndex)'),
          ),
          // child: Utility.shared.webImage(
          //   "src",
          //   fit: BoxFit.fitHeight,
          //   loadingImage: loadingImageName,
          //   errorImage: errorImageName,
          // ),
        );
      },
    );
  }
}
