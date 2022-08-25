import 'dart:developer';

import 'package:flutter/material.dart';

class WWProgressIndicator extends StatefulWidget {
  late double radius = 32.0;
  late BuildContext rootContext;

  WWProgressIndicator({Key? key, this.radius = 32.0}) : super(key: key);

  static WWProgressIndicator shared = WWProgressIndicator();

  @override
  State<WWProgressIndicator> createState() => _WWProgressIndicatorState();

  display({BuildContext? context, double? radius}) {
    final currentContext = context ?? rootContext;

    if (radius != null) {
      this.radius = radius;
    }

    Navigator.of(currentContext).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext currentContext, _, __) => this,
      ),
    );
  }

  void dismiss({BuildContext? context}) {
    final currentContext = context ?? rootContext;

    if (!Navigator.canPop(currentContext)) {
      return;
    }
    Navigator.of(currentContext).pop();
  }
}

class _WWProgressIndicatorState extends State<WWProgressIndicator> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // https://stackoverflow.com/questions/45916658/how-to-deactivate-or-override-the-android-back-button-in-flutter
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.black.withAlpha(64),
        body: Center(
          child: SizedBox(
            width: widget.radius,
            height: widget.radius,
            child: const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.blue),
            ),
          ),
        ),
      ),
    );
  }
}
