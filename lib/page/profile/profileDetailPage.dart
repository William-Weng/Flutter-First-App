import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_first_app/utility/model.dart';
import 'package:flutter_first_app/utility/utility.dart';
import 'package:flutter_first_app/utility/widget/appBar.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ProfileDetailPage extends StatefulWidget {
  final Sample sample;

  const ProfileDetailPage({Key? key, required this.sample}) : super(key: key);

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
          children: [
            InkWell(
              child: Utility.shared.webImage(
                _sample.imageUrl,
              ),
              onDoubleTap: () {
                log('message');
                gotoUrl(_sample.imageUrl);
              },
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
