import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../utility/model/bottomNavigationBarItemModel.dart';
import '/utility/utility.dart';

class ProfileDetailPage extends StatefulWidget {
  final int index;
  final Sample sample;

  const ProfileDetailPage({Key? key, required this.index, required this.sample})
      : super(key: key);

  @override
  State<ProfileDetailPage> createState() => _ProfileDetailPageState();
}

class _ProfileDetailPageState extends State<ProfileDetailPage> {
  late Sample _sample;

  @override
  void initState() {
    super.initState();
    _sample = widget.sample;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.sample.title),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 200,
              child: InkWell(
                child: Hero(
                  tag: "Hero_${widget.index}",
                  child: Utility.shared.webImage(
                    _sample.imageUrl,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                onDoubleTap: () {
                  gotoUrl(_sample.imageUrl);
                },
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _sample.content,
                    style: const TextStyle(
                      fontSize: 32,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Future<bool> gotoUrl(String url) async {
    String urlString = Uri.encodeFull(url);
    return await launchUrlString(urlString);
  }
}
