import 'package:flutter/material.dart';
import 'package:flutter_first_app/utility/utility.dart';

import '/utility/extension.dart';
import '/utility/model/clothes.dart';

class ClothesWidget extends StatefulWidget {
  final List<ClothesModel> models;

  const ClothesWidget({Key? key, required this.models}) : super(key: key);

  @override
  State<ClothesWidget> createState() => _ClothesWidgetState();
}

class _ClothesWidgetState extends State<ClothesWidget> {
  @override
  Widget build(BuildContext context) {
    final gridView = GridView.builder(
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 3,
        childAspectRatio: 0.85,
      ),
      itemCount: widget.models.length,
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

    final model = widget.models.safeElementAt(index);

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
}
